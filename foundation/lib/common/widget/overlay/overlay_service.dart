import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:foundation/common/log/a_logger.dart';


class OverlayService {
  static final OverlayService _instance = OverlayService._internal();

  OverlayService._internal();

  static OverlayService get instance => _instance;

  final Map<String, OverlayEntry> _routes = <String, OverlayEntry>{};
  final Map<String, dynamic> _arguments = <String, dynamic>{};
  final Map<String, AnimationController> _controllers =
      <String, AnimationController>{};
  final Map<String, OverlayBehaviorCallback> _callbacks =
      <String, OverlayBehaviorCallback>{}; // route -> callback>
  /// running background instead of close overlay
  final List<String> _backgroundRoutes = <String>[];

  String? _recent; // 最近一次load的路由route
  String? _current; // 当前正在显示的路由

  dynamic getArgument(String route) => _arguments[route];

  OverlayService load(
    Widget child, {
    required String route,
    dynamic arguments,
    bool runOnBackground = false,
    bool backgroundTapDismiss = true,
    bool fade = false,
  }) {
    _recent = route;
    if (_arguments.containsKey(route)) {
      return this;
    }
    _createOverlay(child,
        route: route, backgroundTapDismiss: backgroundTapDismiss, fade: fade);
    _arguments[route] = arguments;
    if (runOnBackground) _backgroundRoutes.add(route);
    return this;
  }

  _createOverlay(
    Widget child, {
    required String route,
    bool backgroundTapDismiss = false,
    bool fade = false,
  }) {
    final wrapper = GestureDetector(
      onTap: () {
        remove(route: route);
      },
      child: Container(
        color: Colors.black26,
        child: child,
      ),
    );
    final overlayEntry = OverlayEntry(
      builder: (context) => fade
          ? FadeTransition(
              opacity: _controllers[route]!,
              child: backgroundTapDismiss ? wrapper : child)
          : SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ).animate(_controllers[route]!),
              child: backgroundTapDismiss ? wrapper : child,
            ),
    );
    _routes[route] = overlayEntry;
  }

  /// show the latest insert one in list
  void show(
    BuildContext context, {
    OverlayBehaviorCallback? callback,
    dynamic args,
  }) {
    final route = _recent;

    if (route == null) {
      logW('call load() before show()');
      return;
    }

    if (_current == route) {
      resume(context);
      return;
    }

    if (callback != null) {
      _callbacks[route] = callback;
    }

    final controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: Navigator.of(context),
    );

    final overlayEntry = _routes[route]!;

    logI('overlay ready to show: $route');

    Overlay.of(context).insert(overlayEntry);

    /// 拦截返回键
    BackButtonInterceptor.add((bool stopEvent, RouteInfo info) {
      // remove or hide
      logW('route: $route, current: $_current');
      _handleBackButtonInterceptor(route);
      return true;
    }, name: route);

    controller.forward().then((_) => callback?.onShow(args)); // 启动动画
    _controllers[route] = controller;
    _current = route;
  }

  void hide({String? route, dynamic args}) {
    if (_current?.isEmpty == true && route?.isEmpty == true) {
      logW('there is no overlay to hide');
      return;
    }
    final routeToHide = route ?? _current;
    _controllers[routeToHide]?.reverse().then((_) {
      _callbacks[routeToHide]?.onHide(args);
      BackButtonInterceptor.removeByName(routeToHide!);
    });
  }

  void resume(BuildContext context, {String? route, dynamic args}) {
    if (_current?.isEmpty == true && route?.isEmpty == true) {
      logW('there is no overlay to resume');
    }
    final routeToResume = route ?? _current;
    logI('ready to resume: $routeToResume');
    BackButtonInterceptor.add((bool stopEvent, RouteInfo info) {
      _handleBackButtonInterceptor(routeToResume!);
      return true;
    }, name: routeToResume);
    _callbacks[routeToResume]?.onResume(args);
    _controllers[routeToResume]?.forward().then((_) {}); // 恢复动画
  }

  void remove({String? route}) {
    if (_current?.isEmpty == true && route?.isEmpty == true) {
      logW('there is no overlay to remove');
      return;
    }
    final routeToRemove = route ?? _current;
    final overlayEntry = _routes[routeToRemove];
    logI("ready to remove: $routeToRemove");
    BackButtonInterceptor.removeByName(routeToRemove!);
    _controllers[routeToRemove]?.reverse().then((_) {
      _routes.remove(routeToRemove);
      _arguments.remove(routeToRemove);
      _callbacks[routeToRemove]?.onRemove();
      _backgroundRoutes.remove(routeToRemove);
      overlayEntry?.remove();
      // reset anchor
      _current = _routes.keys.lastOrNull;
    });
  }

  void release() {
    for (final overlayEntry in _routes.values) {
      overlayEntry.remove();
    }
    _routes.clear();
    _arguments.clear();
    _controllers.forEach((key, value) => value.dispose());
    _controllers.clear();
    _current = null;
    _recent = null;
    _callbacks.clear();
    _backgroundRoutes.clear();
    BackButtonInterceptor.removeAll();
    logI('all overlay removed');
  }

  /// back button interceptor action: hide or remove
  void _handleBackButtonInterceptor(String route) {
    if (_current != route) return;
    final isBackground = _backgroundRoutes.contains(_current);
    if (isBackground) {
      hide(route: route);
    } else {
      remove(route: route);
    }
  }
}

class OverlayBehaviorCallback {
  void onShow(dynamic args) {}

  void onHide(dynamic args) {}

  void onResume(dynamic args) {}

  void onRemove() {}
}
