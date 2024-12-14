/// app启动策略
/// 可配置环境变量
abstract class ALauncherStrategy {
  bool isDebug = true;

  String get host;

  String get envName;
}

/// 通用策略
abstract class BaseLauncherStrategy extends ALauncherStrategy {}
