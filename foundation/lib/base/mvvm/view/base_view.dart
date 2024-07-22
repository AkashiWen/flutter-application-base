import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../helper/navigation_helper.dart';

/// 支持背景漸變、沉浸式基础page页面
abstract class BaseView<C> extends GetView<C> with NavigationHelper {
  const BaseView({Key? key}) : super(key: key);

  /// 构建appbar
  AppBar? buildAppBar();

  /// 构建drawer
  Widget? buildDrawer(BuildContext context);

  /// 构建bottomNavigation
  Widget? buildBottomNavigation();

  /// 构建floatingAction
  Widget? buildFloatingActionButton();

  /// floatingActionButton位置
  FloatingActionButtonLocation? get floatingActionButtonLocation;

  /// 主视图区域
  Widget buildContent(BuildContext context);

  /// 主视图区域覆盖
  Widget buildContentCover(BuildContext context) => const Offstage();

  /// 纯色背景
  Color get background => Get.theme.primaryColor;

  /// 返回按钮点击
  bool get canPop => true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: Scaffold(
        // appbar
        appBar: buildAppBar(),
        // draw
        drawer: buildDrawer(context) != null
            ? Builder(
                builder: (BuildContext context) => buildDrawer(context)!,
              )
            : null,
        // bottom
        bottomNavigationBar: buildBottomNavigation(),
        // floating action
        floatingActionButton: buildFloatingActionButton(),
        floatingActionButtonLocation: floatingActionButtonLocation,
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (context) => buildBody(context),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: background,
        ),
        buildContent(context),
        buildContentCover(context),
      ],
    );
  }
}
