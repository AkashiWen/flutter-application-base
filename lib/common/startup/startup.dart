import 'package:common/common/startup/dispatcher.dart';
import 'package:flutter/material.dart';

abstract class Startup with Dispatcher {
  /// 创建任务
  Future<bool> create(BuildContext context);

  /// 名称
  String get name;

  /// 依赖任务
  String? get dependency => null;
}
