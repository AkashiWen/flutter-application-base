import 'package:main/app_base/app_base.dart';
import 'package:main/app_base/repository/file_repo.dart';

class DownloadController extends BaseController {
  final FileRepo _fileRepo = Get.find();

  downFile() async {
    logW("downloading");
    showLoading();
    await _fileRepo.download(
      'https://github.com/flutterchina/dio/archive/refs/tags/4.0.4.zip',
      savePath: '/',
      progressListener: (count, total) {
        logV('progress: $count / $total');
        if (count == total) {
          resetShow();
        }
      },
    );
  }
}
