import 'package:foundation/base/mvvm/view/base_view.dart';
import 'package:foundation/common/top.dart';
import 'package:flutter/material.dart';

abstract class BaseGradientPage<C> extends BaseView<C> {
  const BaseGradientPage({Key? key}) : super(key: key);

  /// 渐变背景色
  List<Color>? get gradientColors => [Colors.redAccent, Colors.orangeAccent];

  @override
  Widget? buildBottomNavigation() => null;

  @override
  Widget? buildDrawer(BuildContext context) => null;

  @override
  Widget? buildFloatingActionButton() => null;

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @override
  Widget buildBody(BuildContext context) => Stack(
        children: [
          // 渐变层mask
          gradientColors.isNullOrEmpty
              ? const Offstage()
              : ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: gradientColors!,
                    ).createShader(bounds);
                  },
                  child: Container(
                    color: Colors.white,
                  ),
                ),
          buildContent(context),
          buildContentCover(context),
        ],
      );
}
