import 'package:foundation/common/log/a_logger.dart';
import 'package:get/get.dart';

import '../../../app_base/mvvm/base_controller.dart';
import '../../../app_base/mvvm/base_repo.dart';

class AppBarPageController extends BaseController {
  final MenuRepo _menuRepo = Get.find();

  // @override
  // onInit() {
  //   super.onInit();
  // }

  Future<void> fetchMenuStatus() async {
    logW(".....");
    MenuStatusBeanResponse? holder =
    await apiLaunch(() => _menuRepo.fetchProfile());
    logW("response: ${holder?.dataList}");
  }

  fetchMultiApis()  async {
    var ss = await apiLaunchMany([
      _menuRepo.fetchProfile(),
      _menuRepo.fetchProfile(),
      _menuRepo.fetchProfile(),
    ]);
    logW("apiLaunchMany results: $ss");
  }
}