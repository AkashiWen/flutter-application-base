part of loading;
abstract class ILoading {

  Widget init(BuildContext context, Widget? child);

  void install(Widget loadingWidget);

  void showLoading(bool userInteraction);

  void dismiss();

  void showError(String? message);
}
