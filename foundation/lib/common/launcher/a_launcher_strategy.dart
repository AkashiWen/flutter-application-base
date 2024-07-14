import 'package:package_info_plus/package_info_plus.dart';

/// app启动策略
/// 可配置环境变量
abstract class ALauncherStrategy {
  bool isDebug = true;

  String get host;

  String get envName;

  Future<String> get packageName;

  Future<String> get appVersion;
}

/// 通用策略
abstract class BaseLauncherStrategy extends ALauncherStrategy {
  @override
  Future<String> get appVersion async =>
      (await PackageInfo.fromPlatform()).version;

  @override
  Future<String> get packageName async =>
      (await PackageInfo.fromPlatform()).appName;
}
