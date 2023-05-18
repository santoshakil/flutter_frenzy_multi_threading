import 'package:flutter/material.dart';

extension StringExt on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';

  String get snackCase => toLowerCase().replaceAll(' ', '_');

  bool get isWithout => toLowerCase().contains('without');

  bool get isWith => toLowerCase().contains('with') && !isWithout;

  MaterialColor? get withWithoutColor => isWith
      ? Colors.green
      : isWithout
          ? Colors.red
          : null;
}
