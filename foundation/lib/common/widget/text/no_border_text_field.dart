import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 不带边框的输入框
class NoBorderTextField extends StatelessWidget {
  NoBorderTextField({
    Key? key,
    required this.hintText,
    this.suffix,
    this.text,
    this.onTap,
    this.readOnly = false,
    // 可继续拓展属性
  }) : super(key: key);

  final String hintText;
  final String? text;
  final Widget? suffix;
  final bool readOnly;

  final Function? onTap;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = text ?? "";
    return TextField(
      controller: _controller,
      readOnly: readOnly,
      onTap: () => onTap?.call(),
      decoration: InputDecoration(
        // remove default padding
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
        // suffix icon
        suffixIcon: suffix,
        // remove suffixIcon default padding
        suffixIconConstraints: const BoxConstraints(maxHeight: 56),
        // suffix will show on focus and disappear when not
        // suffix: suffix,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white38,
          fontSize: 14.w,
        ),
        border: InputBorder.none,
        // enabledBorder: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(81))),
        // focusedBorder: const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(81))),
        // 背景色
        // fillColor: Colors.white12,
        // filled: true,
      ),
      // 光标
      cursorColor: Colors.white38,
      cursorWidth: 1.w,
      cursorHeight: 14.w,
      // 输入类型
      keyboardType: TextInputType.number,
      // 小键盘按钮
      // textInputAction: TextInputAction.search,
      style: TextStyle(
        fontSize: 14.w,
        color: Colors.white,
      ),
    );
  }
}
