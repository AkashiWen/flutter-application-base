library loading;

import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

// parts
part 'interface/loading.dart';

part 'impl/easy_loading_impl.dart';

class GLoading extends ILoading {
  static GLoading get instance => _instance;

  factory GLoading() => _instance;
  static final GLoading _instance = GLoading._internal();

  GLoading._internal();

  /// 可選實現類
  final ILoading _proxy = EasyLoadingImpl();

  @override
  Widget init(BuildContext context, Widget? child) {
    return _proxy.init(context, child);
  }

  @override
  void install(Widget loadingWidget) {
    _proxy.install(loadingWidget);
  }

  @override
  void dismiss() {
    _proxy.dismiss();
  }

  @override
  void showLoading(bool userInteraction) {
    _proxy.showLoading(userInteraction);
  }

  @override
  void showError(String? message) {
    _proxy.showError(message);
  }
}
