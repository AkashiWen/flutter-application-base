import 'package:common/base/mvvm/view/base_empty_page.dart';
import 'package:example/app/src/page3/download_controller.dart';
import 'package:flutter/material.dart';

class DownloadPage extends BaseEmptyPage<DownloadController> {
  const DownloadPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.amber,
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          controller.downFile();
        },
        child: const Text('開始下載'),
      ),
    );
  }
}
