import 'package:foundation/common/startup/startup.dart';

import '../startup/database_task.dart';
import '../startup/firebase_task.dart';
import '../startup/free_init_task1.dart';
import '../startup/free_init_task2.dart';
import '../startup/privacy_task.dart';

/// 启动任务表
Map<String, Startup> startupMap = {
  FreeInitTask1.key: FreeInitTask1(),
  FreeInitTask2.key: FreeInitTask2(),
  PrivacyTask.key: PrivacyTask(),
  DataBaseTask.key: DataBaseTask(),
  FireBaseTask.key: FireBaseTask(),
};
