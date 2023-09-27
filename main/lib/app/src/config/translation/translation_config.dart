import 'package:flutter/material.dart';
import 'package:main/app/src/config/translation/translation_cn.dart';
import 'package:main/app/src/config/translation/translation_en.dart';
import 'package:main/app_base/exports.dart';

/// 多语言配置
class TranslationConfig extends Translations {
  static void toEN() {
    var locale = const Locale('en', 'US');
    Get.updateLocale(locale);
  }

  static void toCN() {
    var locale = const Locale('zh', 'CN');
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": enMap,
        "zh_CN": cnMap,
      };
}

class Globalization {
  static const String english = "english";
}
