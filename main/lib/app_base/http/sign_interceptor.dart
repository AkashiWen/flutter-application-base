import 'package:dio/dio.dart' as dio;
import 'package:main/app_base/config/build_config.dart';

/// 请求头拦截器
class SignInterceptor extends dio.Interceptor {
  @override
  void onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    options.headers['x-token'] = BuildConfig.token;
    super.onRequest(options, handler);
  }
}
