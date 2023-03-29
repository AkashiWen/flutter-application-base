abstract class Dispatcher {
  /// 优先级 在有线程池时可以使用
  int get priority;

  /// 是否在主线程执行
  bool get callCreateOnMainThread;
}
