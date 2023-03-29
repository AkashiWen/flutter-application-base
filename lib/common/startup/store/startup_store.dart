import 'dart:math';

import 'package:common/common/log/a_logger.dart';
import 'package:common/common/startup/startup.dart';

/// 存储排好序的startup各种表
class StartupStore {
  StartupStore(
    this.priorityMap,
    this.dependencyMap,
    this.freeStartups,
  );

  /// 执行优先级 {startup: priority}
  Map<String, int> priorityMap = {};

  /// startup依赖关系表 {parent : children}
  Map<String, List<String>> dependencyMap = {};

  /// 可自由初始化的startup
  List<Startup> freeStartups = [];

  /// find the first startup name
  String topNode() {
    int maxNum = -1;
    for (var parent in dependencyMap.keys) {
      maxNum = max(maxNum, priorityMap[parent] ?? -1);
    }
    return priorityMap.entries
        .firstWhere((element) => element.value == maxNum)
        .key;
  }

  void print() {
    logV("优先级: $priorityMap\n"
        "依赖关系表: $dependencyMap\n"
        "自由表: $freeStartups");
  }
}
