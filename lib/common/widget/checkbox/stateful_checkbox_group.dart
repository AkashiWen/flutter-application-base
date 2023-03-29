import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'stateful_check_box.dart';

/// 为一组stateful checkbox实现互斥效果
class StatefulCheckboxGroup extends StatefulWidget {
  const StatefulCheckboxGroup({
    Key? key,
    this.size = 16,
    this.fontSize = 14,
    this.spacing = 24,
    this.runSpacing = 12,
    required this.strings,
    required this.onSelect,
  }) : super(key: key);

  final num size;
  final num fontSize;
  final num spacing;
  final num runSpacing;
  final List<String> strings;
  final Function(int index, bool isSelect) onSelect;

  @override
  State<StatefulCheckboxGroup> createState() => _StatefulCheckboxGroupState();
}

class _StatefulCheckboxGroupState extends State<StatefulCheckboxGroup> {
  /// 存放index位置和选中状态
  late Map<num, bool> _checkMap;

  @override
  void initState() {
    super.initState();
    _checkMap = {};
    widget.strings.asMap().forEach((index, value) {
      /// 选中状态 默认选中第一个
      _checkMap[index] = index == 0;
    });
  }

  @override
  void didUpdateWidget(covariant StatefulCheckboxGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: widget.spacing.w,
        runSpacing: widget.runSpacing.w,
        children: _buildCheckboxes(),
      ),
    );
  }

  List<StatefulCheckbox> _buildCheckboxes() {
    List<StatefulCheckbox> checkboxList = [];
    widget.strings.asMap().forEach((index, value) {
      /// 组件
      checkboxList.add(
        StatefulCheckbox(
          key: ValueKey<num>(index),
          size: widget.size,
          fontSize: widget.fontSize,
          text: value,
          initCheck: _checkMap[index] == true,
          onCheck: (check) {
            // 实现互斥
            setState(() {
              _checkMap.forEach((key, value) {
                _checkMap[key] = false;
              });
              _checkMap[index] = check;
            });
            // callback
            widget.onSelect.call(index, check);
          },
        ),
      );
    });
    return checkboxList;
  }
}
