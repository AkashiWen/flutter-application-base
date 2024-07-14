import 'package:main/app_base/config/build_config.dart';
import 'package:foundation/common/top.dart';

class User {
  // 登录状态
  static bool get isLogin => !BuildConfig.token.isNullOrEmpty;
}