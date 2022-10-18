import 'package:flutter/material.dart';
import 'package:mom_shop/presentation/page/home_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return _FadeRoute(const HomePage(), settings);
    default:
      return _getPageRoute(const HomePage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child, settings);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final RouteSettings routeName;
  _FadeRoute(this.child, this.routeName)
      : super(
          settings: RouteSettings(name: routeName.name),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
