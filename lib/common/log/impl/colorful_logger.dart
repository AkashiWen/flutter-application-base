part of logger;
class ColorfulLogger extends ALogger {
  ColorfulLogger(bool isDebug) {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 10,
        printEmojis: false,
      ),
      filter: MyFilter(isDebug),
    );
  }

  late final Logger logger;

  @override
  void d(String msg, [StackTrace? stackTrace]) => logger.d(msg);

  @override
  void e(String msg, [StackTrace? stackTrace]) => logger.e(msg);

  @override
  void i(String msg, [StackTrace? stackTrace]) => logger.i(msg);

  @override
  void v(String msg, [StackTrace? stackTrace]) => logger.v(msg);

  @override
  void w(String msg, [StackTrace? stackTrace]) => logger.w(msg);

  @override
  void wtf(String msg, [StackTrace? stackTrace]) => logger.wtf(msg);
}

class MyFilter extends LogFilter {
  MyFilter(this.isDebug);

  final bool isDebug;

  @override
  bool shouldLog(LogEvent event) {
    // 非生產環境打印
    return isDebug;
  }
}
