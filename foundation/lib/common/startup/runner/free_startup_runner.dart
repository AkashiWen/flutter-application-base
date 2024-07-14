import 'package:foundation/common/startup/manager/startup_manager.dart';
import 'package:foundation/common/startup/runner/startup_runner.dart';
import 'package:foundation/common/startup/startup.dart';
import 'package:flutter/material.dart';
import 'package:foundation/common/log/a_logger.dart';

/// 无依赖关系的startup执行器
class FreeStartupRunner extends StartupRunner {
  FreeStartupRunner(
    StartupManager manager, {
    required BuildContext context,
    required Startup startup,
  }) : super(manager, context: context, startup: startup);

  @override
  void run() async {
    var startAt = DateTime.now();
    bool result = await startup.create(context);
    var endAt = DateTime.now();
    logV(
        "${startup.name} finish --> result: $result, time used: ${endAt.difference(startAt).inMilliseconds}");
  }
}
