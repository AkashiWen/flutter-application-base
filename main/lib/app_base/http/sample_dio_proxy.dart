import 'package:common/base/mvvm/repo/dio_proxy.dart';
import 'package:dio/src/interceptor.dart';

import '../config/build_config.dart';
import 'sign_interceptor.dart';

/// 举例如何实现DioClient
/// 主要关注host、代理、header、拦截器的注入
/// dio代理实例
class SampleDioProxy extends DioProxy {
  static SampleDioProxy? _instance;

  factory SampleDioProxy.get() => _getInstance();

  static _getInstance() {
    return _instance ??= SampleDioProxy._init();
  }

  SampleDioProxy._init() {
    super.install();
  }

  @override
  String host = BuildConfig.host;

  @override
  String proxy = BuildConfig.proxy;

  @override
  String proxyPort = BuildConfig.proxyPort;

  @override
  Map<String, dynamic> loadDefaultHeader() => {
        "signType": "MD5",
        "clientId": "2",
        "token": BuildConfig.token,
        "typ": "JDBC",
      };

  @override
  List<Interceptor> loadInterceptors() => [
    SignInterceptor(),
  ];
}
