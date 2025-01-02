part of network;

/// 請求結果處理
/// 目前針對dxHttp的ResponseBean進行數據格式轉換
/// 未來可以替換成dio本身
class AResponse<T> {
  AResponse(this.data, {this.code, this.message});

  T? data;

  int? code;

  String? message;

  // 判空
  bool get isEmpty => data == null;

  // 是否請求成功
  bool get isSuccess => code == 200;

  // 是否需要重新登录
  bool get isUnAuthorized => code == 401 || code == 403;

  /// 對dio的Response進行JSON轉換
  static Future<AResponse<T>> convert<T>(
    Future<Response<String>> Function() futureTask,
    T? Function(dynamic data)? onResponse,
  ) async {
    try {
      return await futureTask().then(
        (dioResponse) => handleDioResponse(dioResponse, onResponse),
      );
    } catch (error) {
      if (error is DioError) {
        int code = error.response?.statusCode ?? 0;
        String? msg;
        final responseBody = error.response?.data;
        if (responseBody == null || responseBody == '' || responseBody == {}) {
          msg = error.response?.statusMessage ?? '';
        } else {
          dynamic data = jsonDecode(responseBody);
          msg = data['msg'];
        }

        logger.e('a_response catch DioError: message: $msg, code: $code');
        return AResponse(null, code: code, message: msg);
      }
      return AResponse(null, message: error.toString());
    }
  }

  /// 處理ResponseBean的map數據
  static AResponse<T> handleDioResponse<T>(
    Response<String> dioResponse,
    T? Function(dynamic data)? onResponse,
  ) {
    if (dioResponse.data.isNullOrEmpty) {
      return AResponse(null,
          code: dioResponse.statusCode, message: dioResponse.statusMessage);
    }
    Map<String, dynamic> map = jsonDecode(dioResponse.data!);
    var code = map["code"] ?? dioResponse.statusCode;
    var message = map["message"] ?? map["msg"] ?? dioResponse.statusMessage;
    var data = map["data"] ?? map; // data 可能是List 或 Object 或 基本數據類型（bool）
    logger.w(
        ("---> header status code: ${dioResponse.statusCode}, message: ${dioResponse.statusMessage}"));
    logger.i("---> response: code[$code], || "
        "msg:[$message] || ,\n "
        "${const JsonEncoder.withIndent('  ').convert(data)}");
    return AResponse(
      onResponse?.call(data),
      code: code,
      message: message,
    );
  }
}
