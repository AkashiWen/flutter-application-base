import 'base_sample_launcher_strategy.dart';

/// Production正式环境启动参数
class ProductionLauncherStrategy extends BaseSampleLauncherStrategy {
  @override
  String get envName => "production";

  @override
  String get host => "https://merchant-api.tesoliving.com/";

  @override
  String proxy = "192.168.2.1";

  @override
  String proxyPort = "8888";

  @override
  bool get isDebug => false;
}
