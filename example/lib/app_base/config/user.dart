import 'package:example/app_base/config/build_config.dart';
import 'package:common/common/top.dart';

class User {
  // 登录状态
  static bool get isLogin => !BuildConfig.token.isNullOrEmpty;
}