
import 'package:foundation/base/route/a_route.dart';
import 'package:main/app/src/page3/download_controller.dart';
import 'package:main/app/src/page3/download_page.dart';
import 'package:main/app_base/repository/file_repo.dart';

import '../../../app_base/config/route_name.dart';
import '../page1/home_page.dart';
import '../page1/home_page_controller.dart';
import '../page2/appbar_page.dart';
import '../page2/appbar_page_controller.dart';
import '../../../app_base/mvvm/base_repo.dart';
import 'package:get/get.dart';

/// 服务项目的页面路由配置
class RouteConfig extends ARoute {

  @override
  List<GetPage> getPages() => [
        GetPage<dynamic>(
          name: RouteName.home,
          page: () =>  HomePage(),
          binding: BindingsBuilder<HomePageController>(() {
            Get.lazyPut(() => HomePageController());
          }),
        ),
        GetPage(
          name: RouteName.appBarPage,
          page: () => const AppBarPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => AppBarPageController());
            Get.lazyPut(() => MenuRepo());
          }),
        ),

        GetPage(
          name: RouteName.download,
          page: () => const DownloadPage(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => DownloadController());
            Get.lazyPut(() => FileRepo());
          }),
        ),
      ];

  @override
  String initialRoute = RouteName.home;

  @override
  String? loginRoute;
}
