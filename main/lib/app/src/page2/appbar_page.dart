import 'package:common/base/mvvm/view/base_appbar_page.dart';
import 'package:common/common/top.dart';
import 'package:flutter/material.dart';

import 'appbar_page_controller.dart';

class AppBarPage extends BaseAppBarPage<AppBarPageController> {
  const AppBarPage({super.key});

  @override
  String get appBarTitle => "title";

  @override
  onTapLeft() {
    return super.onTapLeft();
  }

  @override
  onTapRight(BuildContext context) async {
    showToast("tap right");
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text("自带appbar的page演示"),
          ElevatedButton(
            onPressed: () {
              controller.showLoading(userInteraction: false);
            },
            child: const Text("测试loading"),
          ),
          ElevatedButton(
            onPressed: () {
              controller.fetchMenuStatus();
            },
            child: const Text("测试单个请求"),
          ),
          ElevatedButton(
            onPressed: () {
              controller.fetchMultiApis();
            },
            child: const Text("测试多个请求"),
          ),
        ],
      ),
    );
  }
}
