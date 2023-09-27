import 'base_sample_launcher_strategy.dart';

/// Dev开发环境启动参数
class DevLauncherStrategy extends BaseSampleLauncherStrategy {
  @override
  String get envName => "dev";

  @override
  String get host => "http://172.19.0.135:8082/bw-volunteer-api/";

  @override
  String proxy = "";

  @override
  String proxyPort = "8888";
}
