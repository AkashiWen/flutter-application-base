import 'package:common/common/log/a_logger.dart';
import 'package:common/common/startup/runner/startup_runner.dart';
import 'package:common/common/startup/startup.dart';
import 'package:flutter/material.dart';

import '../manager/startup_manager.dart';

/// 存在依赖关系的startup执行器
class DependencyStartupRunner extends StartupRunner {
  DependencyStartupRunner(
    StartupManager manager, {
    required BuildContext context,
    required Startup startup,
  }) : super(manager, context: context, startup: startup);

  @override
  void run() async {
    // 1. run self
    var startAt = DateTime.now();
    bool result = await startup.create(context);
    var endAt = DateTime.now();
    logV(
        "${startup.name} finish --> result: $result, time used: ${endAt.difference(startAt).inMilliseconds}");

    // 2. find children
    if (result) {
      manager.notifyChildren(startup.name);
    }
  }
}
