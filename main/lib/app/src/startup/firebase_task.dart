import 'package:foundation/common/log/a_logger.dart';
import 'package:foundation/common/startup/flutter_startup.dart';
import 'package:flutter/material.dart';

import 'privacy_task.dart';

class FireBaseTask extends FlutterStartup {
  static String key = 'FireBaseTask';

  @override
  String get name => key;

  @override
  Future<bool> create(BuildContext context) async {
    logW("start up FireBaseTask...");
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(true);
  }

  @override
  String? get dependency => PrivacyTask.key;

}
