import 'dart:async';

import 'package:foundation/common/top.dart';
import 'package:main/app_base/exports.dart';
import 'package:flutter/cupertino.dart';

import 'launcher/strategy/base_sample_launcher_strategy.dart';
import 'src/config/route_config.dart';
import 'src/my_app.dart';

/// app启动器
class AppLauncher {
  /// 启动 - 通过启动策略启动
  static void launch(
    BaseSampleLauncherStrategy launcherStrategy,
  ) {
    // 将启动策略中带入的配置写进环境变量BuildConfig给全局使用
    BuildConfig.envName = launcherStrategy.envName;
    BuildConfig.host = launcherStrategy.host;
    BuildConfig.isDebug = launcherStrategy.isDebug;
    BuildConfig.proxy = launcherStrategy.proxy;
    BuildConfig.proxyPort = launcherStrategy.proxyPort;

    void reportErrorAndLog(FlutterErrorDetails details) {
      final errorMsg = {
        "exception": details.exceptionAsString(),
        "stackTrace": details.stack.toString(),
      };
      logE('reportErrorAndLog: $errorMsg');
      showToast('reportErrorAndLog: ${errorMsg['exception']}');
    }

    FlutterError.onError = (FlutterErrorDetails details) {
      //获取 widget build 过程中出现的异常错误
      reportErrorAndLog(details);
    };

    runZonedGuarded(
        () => runApp(MyApp(
              launcherStrategy: launcherStrategy,
              route: RouteConfig(),
            )), (error, stack) {
      // 没被我们catch的异常
      reportErrorAndLog(FlutterErrorDetails(stack: stack, exception: error));
    });
  }
}
