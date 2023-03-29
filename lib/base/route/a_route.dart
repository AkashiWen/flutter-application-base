import 'package:get/get.dart';

/// 路由管理
abstract class ARoute {

  /// 路由列表
  List<GetPage> getPages();

  /// 第一个页面
  abstract String initialRoute;

  /// 登录页面
  abstract String? loginRoute;
}
