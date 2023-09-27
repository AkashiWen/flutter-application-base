import 'package:main/app_base/app_base.dart';
import 'package:main/app_base/config/colors.dart';
import 'package:flutter/material.dart';

/// tabbar + tabbarview
class TabBarContentWidget extends StatefulWidget {
  const TabBarContentWidget({
    Key? key,
    required this.tabs,
    required this.tabBarViews,
    this.onTabChanged,
  }) : super(key: key);

  final List<String> tabs;
  final List<Widget> tabBarViews;
  final Function(int index)? onTabChanged;

  @override
  State<TabBarContentWidget> createState() => _TabBarContentWidgetState();
}

class _TabBarContentWidgetState extends State<TabBarContentWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List _tabs;
  late int index = 0;

  @override
  void initState() {
    super.initState();
    _tabs = widget.tabs;
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      index = _tabController.index;
      widget.onTabChanged?.call(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((e) => Tab(text: e)).toList(),
              indicatorColor: AColors.ff13a07b,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AColors.ff13a07b,
                  width: 3.w,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              unselectedLabelColor: AColors.ff232323,
              labelColor: AColors.ff13a07b,
              labelStyle: TextStyle(fontSize: 14.w),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabBarViews,
          ),
        ),
      ],
    );
  }
}
