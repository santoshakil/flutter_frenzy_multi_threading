import 'package:flutter/material.dart';

ThemeData get defaultDarkTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.teal,
      cardTheme: const CardTheme(shape: circular20Shape),
      listTileTheme: const ListTileThemeData(shape: circular20Shape),
    );

const circular20Shape = RoundedRectangleBorder(borderRadius: circular20Border);
const circular20Border = BorderRadius.all(Radius.circular(20));
