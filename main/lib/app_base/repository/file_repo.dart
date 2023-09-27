import 'package:main/app_base/exports.dart';

class FileRepo extends BaseRepo {
  Future downFile(
    String url, {
    required String savePath,
  }) {
    return download(url, savePath: savePath);
  }
}
