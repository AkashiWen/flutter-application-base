import 'package:common/common/launcher/a_launcher_strategy.dart';

/// 服务于具体项目的启动策略配置，可根据需要拓展
abstract class BaseSampleLauncherStrategy extends BaseLauncherStrategy {
  /// 代理服务器
  abstract String proxy;

  /// 代理服务器端口
  abstract String proxyPort;

  // 例子 拓展
  // abstract bool isWhat;
  // abstract String slogan;
}
