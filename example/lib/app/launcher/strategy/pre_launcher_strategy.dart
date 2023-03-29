import 'base_sample_launcher_strategy.dart';

/// Pre预发布环境启动参数
class PreLauncherStrategy extends BaseSampleLauncherStrategy {
  @override
  String get envName => "pre";

  @override
  String get host => "https://pre-merchant-api.tesoliving.com/";

  @override
  String proxy = "192.168.2.1";

  @override
  String proxyPort = "8888";
}
