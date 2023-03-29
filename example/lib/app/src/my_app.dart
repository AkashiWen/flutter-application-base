import 'package:common/base/app/base_material_app.dart';
import 'package:common/base/route/a_route.dart';
import 'package:common/common/log/a_logger.dart';
import 'package:common/common/startup/startup.dart';

import '../../app_base/config/build_config.dart';
import '../../app_base/config/user.dart';
import '../launcher/strategy/base_sample_launcher_strategy.dart';

/// app
// ignore: must_be_immutable
class MyApp extends BaseMaterialApp<BaseSampleLauncherStrategy> {
  MyApp({
    super.key,
    required BaseSampleLauncherStrategy launcherStrategy,
    required ARoute route,
  }) : super(launcherStrategy, route);

  @override
  void init() {
    super.init();
    // 初始化项目自身业务，比如登录状态token等
    BuildConfig.token = 'your token';
    logI("check login status: ${User.isLogin}");
  }

  @override
  void buildConfig(BaseSampleLauncherStrategy launcherStrategy) {
    // 将启动策略中带入的配置写进环境变量BuildConfig给全局使用
    String env = launcherStrategy.envName;
    String host = launcherStrategy.host;
    bool isDebug = launcherStrategy.isDebug;
    String proxy = launcherStrategy.proxy;
    String proxyPort = launcherStrategy.proxyPort;
    logI(
        "my_app.dart: launcher strategy env: $env, isDebug: $isDebug, host: $host, proxy: $proxy");
    BuildConfig.envName = env;
    BuildConfig.isDebug = isDebug;
    BuildConfig.host = host;
    BuildConfig.proxy = proxy;
    BuildConfig.proxyPort = proxyPort;
  }

// @override
// GetMaterialApp buildApp(BuildContext context, Widget? child) =>
//     GetMaterialApp(
//       getPages: route.getPages(),
//       initialRoute: route.initialRoute,
//       defaultTransition: Transition.rightToLeftWithFade,
//     );
}
