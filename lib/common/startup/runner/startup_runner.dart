import 'package:flutter/material.dart';

import '../startup.dart';
import '../manager/startup_manager.dart';

abstract class StartupRunner {
  StartupRunner(
    this.manager, {
    required this.context,
    required this.startup,
  });

  final StartupManager manager;
  final BuildContext context;
  final Startup startup;

  run();
}
