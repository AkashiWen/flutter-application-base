part of logger;

/// 靜態代理logger
class LoggerProxy extends ALogger {
  LoggerProxy._internal();

  static LoggerProxy? _instance;

  factory LoggerProxy.getInstance() => _getInstance();

  static _getInstance() {
    _instance ??= LoggerProxy._internal();
    return _instance;
  }

  // 代理Logger
  late final ALogger? _proxy;

  void _setProxy(ALogger logger) {
    _proxy = logger;
  }

  @override
  void d(String msg, [StackTrace? stackTrace]) => _proxy?.d(msg);

  @override
  void e(String msg, [StackTrace? stackTrace]) => _proxy?.e(msg);

  @override
  void i(String msg, [StackTrace? stackTrace]) => _proxy?.i(msg);

  @override
  void v(String msg, [StackTrace? stackTrace]) => _proxy?.v(msg);

  @override
  void w(String msg, [StackTrace? stackTrace]) => _proxy?.w(msg);

  @override
  void wtf(String msg, [StackTrace? stackTrace]) => _proxy?.wtf(msg);
}

void installLogger([bool isDebug = true, ALogger? logger]) {
  logger ??= ColorfulLogger(isDebug);
  LoggerProxy.getInstance()._setProxy(logger);
}
