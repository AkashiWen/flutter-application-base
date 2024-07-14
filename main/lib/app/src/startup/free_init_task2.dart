import 'package:foundation/common/startup/flutter_startup.dart';

import 'package:foundation/common/log/a_logger.dart';
import 'package:flutter/material.dart';

class FreeInitTask2 extends FlutterStartup {
  static String key = 'FreeInitTask2';

  @override
  Future<bool> create(BuildContext context) async {
    logW("FreeInitTask2 startup..");
    await Future.delayed(const Duration(seconds: 4));
    return Future.value(true);
  }

  @override
  String get name => key;
}
