import 'dart:collection';

import 'package:common/common/log/a_logger.dart';
import 'package:common/common/startup/runner/dependency_startup_runner.dart';
import 'package:common/common/startup/runner/free_startup_runner.dart';
import 'package:common/common/top.dart';
import 'package:flutter/material.dart';

import '../startup.dart';

import '../store/startup_store.dart';

class StartupManager {
  StartupManager(this.context, this._startupMap);

  /// 上下文
  final BuildContext context;

  /// startup 实例映射存储
  final Map<String, Startup> _startupMap;

  /// 排序后的存储
  late StartupStore _startupStore;

  /// 启动startups
  void start() {
    // 1. 检查
    if (_startupMap.isNullOrEmpty) return;

    // 2. 构建表
    _startupStore = _sort();

    // 3. 打印结果
    _startupStore.print();

    // 4. 执行
    // 4.1 执行依赖表
    _startupStore.dependencyMap.forEach((parent, children) {
      DependencyStartupRunner(
        this,
        context: context,
        startup: _startupMap[parent]!,
      ).run();
    });
    // 4.2 执行自由表
    for (Startup freeStartup in _startupStore.freeStartups) {
      FreeStartupRunner(
        this,
        context: context,
        startup: freeStartup,
      ).run();
    }
  }

  StartupStore _sort() {
    Map<String, int> priorityMap = {}; // 执行优先级
    Map<String, List<String>> dependencyMap = {}; // startup依赖关系表
    List<Startup> freeStartups = []; // 可自由初始化的startup

    for (Startup startup in _startupMap.values) {
      // 2.1 执行优先级
      priorityMap[startup.name] = startup.priority;
      // 2.2 父子依赖表
      String parentName = startup.dependency.val;
      if (parentName.isNotEmpty) {
        // 存在上级依赖
        _dependency(
          parentName,
          dependencyMap,
          startup.name,
        );
      }
    }
    // 2.3 自由表
    for (Startup startup in _startupMap.values) {
      String parentName = startup.dependency.val;
      // 没有上级依赖，并且不在依赖关系表的，可以随意初始化
      if (parentName.isNullOrEmpty && dependencyMap[startup.name] == null) {
        freeStartups.add(startup);
      }
    }
    return StartupStore(priorityMap, dependencyMap, freeStartups);
  }

  _dependency(String parent, Map<String, List<String>> map, String child) {
    List<String>? children = map[parent];
    if (children.isNullOrEmpty) {
      children = [];
    }
    children?.add(child);
    map[parent] = children!;
  }

  /// 执行子任务
  notifyChildren(String parent) {
    List<String>? children = _startupStore.dependencyMap[parent];
    children?.forEach((child) {
      DependencyStartupRunner(
        this,
        context: context,
        startup: _startupMap[child]!,
      ).run();
    });
  }
}
