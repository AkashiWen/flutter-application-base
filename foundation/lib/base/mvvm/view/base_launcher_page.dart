import 'package:foundation/common/top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/startup/manager/startup_manager.dart';
import '../../../common/startup/startup.dart';
import 'base_gradient_page.dart';

/// 基础启动页面，整合启动项Startup
abstract class BaseLauncherPage<C> extends BaseGradientPage<C> {
  BaseLauncherPage({
    Key? key,
  }) : super(key: key) {
    Map<String, Startup>? startupMap = loadStartups();
    if (!startupMap.isNullOrEmpty) {
      // 等待页面build完毕，执行startup
      WidgetsBinding.instance.addPostFrameCallback((_) {
        StartupManager(Get.context!, startupMap!).start();
      });
    }
  }

  @override
  AppBar? buildAppBar() => null;

  @override
  Widget? buildDrawer(BuildContext context) => null;

  @override
  Widget? buildBottomNavigation() => null;

  Map<String, Startup>? loadStartups();
}
