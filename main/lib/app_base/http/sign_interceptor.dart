import 'package:dio/dio.dart' as dio;
import 'package:get/get_connect/http/src/multipart/form_data.dart';


/// 请求头拦截器
class SignInterceptor extends dio.Interceptor {
  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    // if (!Url.token.isNullOrEmpty) {
    //   options.headers["accessToken"] = Url.token;
    //   options.headers["typ"] = "JDBC";
    // }
    bool isEmpty = true;
    //param排序
    if (options.queryParameters.isNotEmpty) {
      isEmpty = false;
      getSign(options.queryParameters);
    }
    //data排序
    if (options.data != null && options.data is! FormData) {
      isEmpty = false;
      getSign(options.data);
    }
    if (isEmpty) {
      getSign(options.queryParameters);
    }
    super.onRequest(options, handler);
  }

  static getSign(Map<String, dynamic> paramMap) {
    Map<String, dynamic> jsonStringMap = {};
    paramMap["BwTime"] = DateTime.now().millisecondsSinceEpoch;
    // paramMap["platform"] = AppConstant.getPlatformCode();
    // paramMap["version"] = AppConstant.VERSION;

    //当value是object或array时转string----start
    paramMap.forEach((key, value) {
      if (value is List || value is Map) {
        jsonStringMap[key] = value.toString();
      }
    });
    jsonStringMap.forEach((key, value) {
      paramMap.remove(key);
      paramMap["_$key"] = value;
    });
    //当value是object或array时转string----end
    var attrKeys = paramMap.keys.toList();
    attrKeys.sort();
    String sign = "";
    for (var element in attrKeys) {
      if (paramMap[element] != null) {
        sign += paramMap[element].toString();
      } else {
        paramMap.remove(element);
      }
    }
    // TODO
    // sign += "xldfjeijflskslfjsalkdfjlasglakgjdjkhgkruiei";
    // paramMap["_client_sign"] = BaseUtils.md5Encoder(sign);
    return paramMap;
  }
}
