part of loading;

/// 基于EasyLoading的实现
class EasyLoadingImpl extends ILoading {
  @override
  Widget init(BuildContext context, Widget? child) {
    return EasyLoading.init()(context, child);
  }

  @override
  void install(Widget loadingWidget) {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorWidget = loadingWidget
      ..textColor = Colors.black54
      ..indicatorColor = Colors.red
      ..backgroundColor = Colors.transparent
      ..progressColor = Colors.yellow
      ..maskColor = Colors.transparent
      ..boxShadow = [];
  }

  @override
  void dismiss() {
    EasyLoading.dismiss();
  }

  @override
  void showLoading(bool userInteraction) {
    EasyLoading.instance.userInteractions = userInteraction;
    EasyLoading.show();
  }

  @override
  void showError(String? message) {
    EasyLoading.showError(message ?? "");
  }
}
