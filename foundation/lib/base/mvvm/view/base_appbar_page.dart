import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'base_view.dart';

/// 基础带appbar的page
abstract class BaseAppBarPage<C> extends BaseView<C> {
  const BaseAppBarPage({Key? key}) : super(key: key);

  /// appbar标题
  abstract final String appBarTitle;

  /// appbar shadow深度
  double? get appBarElevation => null;

  /// 動態appbar標題
  RxString? get rxAppbarTitle => null;

  /// 標題文字顏色
  Color get appBarTitleColor => Colors.white;

  /// 加载appbar背景色
  Color get appbarBackgroundColor => const Color.fromARGB(255, 33, 33, 33);

  /// 底部导航栏颜色
  Color? get bottomNavigationBarColor => null;

  /// 頂部狀態欄顏色
  Color? get statusBarColor => null;

  /// 左边按钮图标
  Widget? buildLeftIcon() => const Icon(Icons.arrow_back_outlined);

  /// 右边按钮图标
  Widget? buildRightIcon() => const Icon(Icons.menu_rounded);

  /// 左边按钮点击
  void onTapLeft() => finish();

  /// 右边按钮点击
  void onTapRight(BuildContext context) => {};

  @override
  Widget? buildDrawer(BuildContext context) => null;

  @override
  AppBar? buildAppBar() => _customAppBar();

  @override
  Widget? buildBottomNavigation() => null;

  @override
  Widget? buildFloatingActionButton() => null;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  /// 自定义AppBar (leading & actions)
  AppBar _customAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: appBarElevation,
      title: rxAppbarTitle != null
          ? Obx(
            () => Text(
          rxAppbarTitle?.value ?? '',
          style: TextStyle(
            fontSize: 18.w,
            fontWeight: FontWeight.w700,
            color: appBarTitleColor,
          ),
        ),
      )
          : Text(
        appBarTitle,
        style: TextStyle(
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          color: appBarTitleColor,
        ),
      ),
      leading: InkWell(
        onTap: () => onTapLeft.call(),
        child: Container(
          padding: EdgeInsets.only(left: 12.w),
          alignment: Alignment.centerLeft,
          child: buildLeftIcon(),
        ),
      ),
      leadingWidth: 100,
      backgroundColor: appbarBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        systemNavigationBarColor: bottomNavigationBarColor,
      ),
      actions: [
        Builder(
          builder: (context) => InkWell(
            onTap: () => onTapRight.call(context),
            child: Container(
              padding: EdgeInsets.only(right: 12.w, left: 12.w),
              alignment: Alignment.centerRight,
              child: buildRightIcon(),
            ),
          ),
        ),
      ],
    );
  }
}
