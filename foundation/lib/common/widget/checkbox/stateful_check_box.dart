import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 自带状态的checkbox
// ignore: must_be_immutable
class StatefulCheckbox extends StatefulWidget {
  const StatefulCheckbox({
    Key? key,
    this.size = 16,
    this.initCheck = false,
    required this.onCheck,
    this.text,
    this.fontSize = 14,
  }) : super(key: key);

  final num size;
  final bool initCheck;

  final String? text;
  final num fontSize;

  final Function(bool isChecked) onCheck;

  @override
  State<StatefulCheckbox> createState() => _StatefulCheckboxState();
}

class _StatefulCheckboxState extends State<StatefulCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initCheck;
  }

  @override
  void didUpdateWidget(covariant StatefulCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 外层组件通知更新时
    isChecked = widget.initCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // wrap_content
      mainAxisSize: MainAxisSize.min,
      children: [
        /// checkbox
        Container(
          margin: const EdgeInsets.all(2),
          width: widget.size.w,
          height: widget.size.w,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Checkbox(
            value: isChecked,
            activeColor: const Color(0xFFFCD700),
            checkColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            side: BorderSide.none,
            onChanged: (value) {
              setState(() {
                isChecked = !isChecked;
                widget.onCheck.call(isChecked);
              });
            },
          ),
        ),

        SizedBox(width: 4.w),

        /// text
        InkWell(
          onTap: () => setState(() {
            isChecked = !isChecked;
            widget.onCheck.call(isChecked);
          }),
          child: Text(
            widget.text ?? "",
            style: TextStyle(
              fontFamily: 'GenSen',
              fontSize: widget.fontSize.w,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFDFDFDF),
            ),
          ),
        )
      ],
    );
  }
}
