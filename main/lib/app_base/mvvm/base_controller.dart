import 'package:foundation/base/mvvm/vm/base_view_model.dart';
import 'package:foundation/common/log/a_logger.dart';
import 'package:foundation/common/top.dart';

class BaseController extends BaseViewModel {
  @override
  void handleUnAuthorizedError(String? message) {
    showToast("401 or 403 : $message");
  }

  @override
  void showEmpty() {}

  @override
  void showError(String? message) {
    showToast(message);
  }

  @override
  void handleServerError(String? message) {
    logE(message);
  }

  @override
  void onHidden() {
  }

}
