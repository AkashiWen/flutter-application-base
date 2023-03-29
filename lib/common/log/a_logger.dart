library logger;

import 'package:logger/logger.dart';

part 'logger_proxy.dart';
part './impl/colorful_logger.dart';

abstract class ALogger {
  void v(String msg, [StackTrace? stackTrace]);

  void d(String msg, [StackTrace? stackTrace]);

  void i(String msg, [StackTrace? stackTrace]);

  void w(String msg, [StackTrace? stackTrace]);

  void e(String msg, [StackTrace? stackTrace]);

  void wtf(String msg, [StackTrace? stackTrace]);
}


void logV(String? msg) => LoggerProxy.getInstance().v(msg ?? "");

void logD(String? msg) => LoggerProxy.getInstance().d(msg ?? "");

void logI(String? msg) => LoggerProxy.getInstance().i(msg ?? "");

void logW(String? msg) => LoggerProxy.getInstance().w(msg ?? "");

void logE(String? msg) => LoggerProxy.getInstance().e(msg ?? "");

void logWtf(String? msg) => LoggerProxy.getInstance().wtf(msg ?? "");