import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundation/common/widget/overlay/overlay_service.dart';
import 'package:get/get.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({super.key, required this.onSubmit});

  final Function(String value) onSubmit;

  static void show(
    BuildContext context, {
    required Function(String value) onSubmit,
  }) {
    OverlayService.instance
        .load(
          InputWidget(onSubmit: (String value) => onSubmit(value)),
          route: 'InputWidget',
          fade: true,
        )
        .show(context);
  }

  static void showDialog(
    BuildContext context, {
    required Function(String value) onSubmit,
  }) {
    Get.dialog(InputWidget(onSubmit: (String value) => onSubmit(value)));
  }

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 0.8.sw,
          height: 0.37.sh,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText('Filter Keywords', fontSize: 20.sp),
                SizedBox(height: 12.h),
                _buildText('Enter  Keywords to filter from comments',
                    fontSize: 14.sp),
                SizedBox(height: 12.h),
                TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    widget.onSubmit(value);
                  },
                  style: TextStyle(
                    fontSize: 14.sp,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                  maxLength: 10,
                  decoration: const InputDecoration(
                      hintText: 'Keywords must be 10 characters',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: Colors.grey,
                      )),
                ),

                SizedBox(height: 24.h),
                // ok cancel
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        OverlayService.instance.remove();
                      },
                      child: _buildText('Cancel',
                          fontSize: 14.sp, color: Colors.teal),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onSubmit(_controller.text);
                        OverlayService.instance.remove();
                      },
                      child:
                          _buildText('OK', fontSize: 14.sp, color: Colors.teal),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildText(String text, {double fontSize = 10, Color color = Colors.black}) =>
      Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          decoration: TextDecoration.none,
        ),
      );
}
