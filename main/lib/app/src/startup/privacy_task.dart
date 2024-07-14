import 'dart:async';

import 'package:foundation/common/log/a_logger.dart';
import 'package:foundation/common/startup/flutter_startup.dart';
import 'package:flutter/material.dart';
import 'package:foundation/common/top.dart';

class PrivacyTask extends FlutterStartup {
  static String key = 'PrivacyTask';

  @override
  String get name => key;

  @override
  Future<bool> create(BuildContext context) async {
    logW('start up $key');

    // 模拟隐私协议对话框
    bool? result = await showConfirmCancelDialog(
      context,
      title: '注意',
      content: '请同意隐私协议以进行软件sdk初始化',
      shouldCloseOnConfirm: () async {
        return true;
      },
      onConfirm: () {
        logV("对话框关闭");
      },
    );

    return result ?? false;
  }
}
