import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this).copyWith(textScaleFactor: 1.0, devicePixelRatio: 1.0);

  ThemeData get theme => Theme.of(this);

  TextTheme get text => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;

  Size get size => mq.size;

  double get width => size.width;

  double get height => size.height;

  NavigatorState get nav => Navigator.of(this);

  void pop<T>([T? result]) => nav.pop<T>(result);

  Future<T?> push<T>(Widget page) => nav.push<T>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushReplacement<T>(Widget page) => nav.pushReplacement<T, T?>(MaterialPageRoute(builder: (_) => page));

  Future<T?> pushAndRemoveUntil<T>(Widget page) =>
      nav.pushAndRemoveUntil<T>(MaterialPageRoute(builder: (_) => page), (_) => false);
}
