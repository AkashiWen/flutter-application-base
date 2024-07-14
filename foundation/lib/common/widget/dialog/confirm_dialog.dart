import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 取消 - 确认 对话框
class ConfirmDialog extends AlertDialog {
  ConfirmDialog({
    Key? key,
    Widget? title,
    Color? backgroundColor,
    required Widget content,
    required Future<bool> Function() shouldCloseOnConfirm,
    required Function onConfirm,
  }) : super(
          key: key,
          backgroundColor: backgroundColor ?? const Color(0xFF212121),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          title: title,
          content: content,
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text(
                "取消",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFCD700),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                // callback
                bool dismiss = await shouldCloseOnConfirm.call() == true;
                if (dismiss) {
                  Get.back(result: true);
                  onConfirm.call();
                }
              },
              child: const Text(
                "確認",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFFCD700),
                ),
              ),
            ),
          ],
        );
}
