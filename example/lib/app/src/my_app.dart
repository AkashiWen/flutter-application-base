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
  }

// @override
// GetMaterialApp buildApp(BuildContext context, Widget? child) =>
//     GetMaterialApp(
//       getPages: route.getPages(),
//       initialRoute: route.initialRoute,
//       defaultTransition: Transition.rightToLeftWithFade,
//     );
}
