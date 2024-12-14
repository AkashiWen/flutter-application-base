import 'package:foundation/base/app/base_material_app.dart';
import 'package:foundation/base/route/a_route.dart';

import '../../app_base/exports.dart';
import '../launcher/strategy/base_sample_launcher_strategy.dart';
import 'config/translation/translation_config.dart';

/// app
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

  @override
  Translations? buildTranslations() => TranslationConfig();


// @override
// GetMaterialApp buildApp(BuildContext context, Widget? child) =>
//     GetMaterialApp(
//       getPages: route.getPages(),
//       initialRoute: route.initialRoute,
//       defaultTransition: Transition.rightToLeftWithFade,
//     );
}
