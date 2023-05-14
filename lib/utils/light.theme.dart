import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';


const lightUiConfig = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
);

const lightPrimaryColor = Color(0xFFF0836B);
const _headLineTextColor = Color(0xFF1B3A68);
const _iconColorSecondary = Color(0xFF6A81A4);
const _backgroundColor = Colors.white;
const _bodyTextColor = Color(0xFF6A81A4);
const _unselectedColor = Color(0xFF6A81A4);
const _titleTextColor = Color(0xFF1B3A68);
const _primaryLightColor = Color(0xFFFFE7E7);
const _cardBackgroundColor = Color(0xFFF2F4FA);
const _scaffoldBackgroundColor = Color(0xFFF2F4FA);
const _floatingActionButtonColor = Color.fromARGB(255, 238, 123, 98);
const _shadowColor = Color.fromARGB(100, 200, 200, 200);

final lightTheme = ThemeData(
  useMaterial3: true,
  cardTheme: _cardTheme,
  textTheme: _textTheme,
  radioTheme: _radioTheme,
  shadowColor: _shadowColor,
  appBarTheme: _appBarTheme,
  tabBarTheme: _tabBarTheme,
  dialogTheme: _dialogTheme,
  switchTheme: _switchTheme,
  tooltipTheme: _tooltipTheme,
  brightness: Brightness.light,
  listTileTheme: _listTileTheme,
  snackBarTheme: _snackBarTheme,
  primaryColor: lightPrimaryColor,
  cardColor: _cardBackgroundColor,
  // backgroundColor: _backgroundColor,
  unselectedWidgetColor: _unselectedColor,
  bottomNavigationBarTheme: _bottomNavBar,
  textSelectionTheme: _textSelectionTheme,
  secondaryHeaderColor: _primaryLightColor,
  outlinedButtonTheme: _outlinedButtonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  indicatorColor: _floatingActionButtonColor,
  progressIndicatorTheme: _progressIndicatorTheme,
  inputDecorationTheme: _lightInputDecorationTheme,
  scaffoldBackgroundColor: _scaffoldBackgroundColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  floatingActionButtonTheme: _floatingActionButtonTheme,
  iconTheme: const IconThemeData(color: _iconColorSecondary),
  primaryIconTheme: const IconThemeData(color: lightPrimaryColor),
);

final _switchTheme = SwitchThemeData(
  thumbColor: MaterialStateProperty.all(lightPrimaryColor),
  trackColor: MaterialStateProperty.all(lightPrimaryColor.withOpacity(0.5)),
);

final _lightInputDecorationTheme = InputDecorationTheme(
  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  enabledBorder: OutlineInputBorder(
    borderRadius: borderRadius12,
    gapPadding: 10,
    borderSide: const BorderSide(color: _bodyTextColor, width: 1.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: borderRadius12,
    gapPadding: 10,
    borderSide: BorderSide(color: _bodyTextColor.withOpacity(0.4), width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: borderRadius12,
    gapPadding: 10,
    borderSide: const BorderSide(color: lightPrimaryColor, width: 1.3),
  ),
  floatingLabelStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: lightPrimaryColor,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: borderRadius12,
    gapPadding: 10,
    borderSide: const BorderSide(color: Colors.red, width: 1.3),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: borderRadius12,
    gapPadding: 10,
    borderSide: const BorderSide(color: Colors.red, width: 1.3),
  ),
  suffixIconColor: lightPrimaryColor,
  prefixIconColor: lightPrimaryColor,
  errorMaxLines: 3,
);

const _textSelectionTheme = TextSelectionThemeData(
  cursorColor: lightPrimaryColor,
  selectionColor: lightPrimaryColor,
  selectionHandleColor: lightPrimaryColor,
);

final _snackBarTheme = SnackBarThemeData(
  actionTextColor: _textTheme.labelSmall!.color,
  contentTextStyle: _textTheme.labelSmall,
  backgroundColor: Colors.transparent,
  behavior: SnackBarBehavior.floating,
  shape: roundedRectangleBorder30,
  elevation: 0.0,
);

final _tabBarTheme = TabBarTheme(
  labelColor: lightPrimaryColor,
  unselectedLabelColor: _unselectedColor,
  indicatorSize: TabBarIndicatorSize.label,
  indicator: BoxDecoration(borderRadius: borderRadius30),
);

final _cardTheme = CardTheme(
  shape: roundedRectangleBorder12,
  shadowColor: _shadowColor,
  color: _backgroundColor,
  elevation: 0,
);

final _radioTheme = RadioThemeData(
  fillColor: MaterialStateProperty.all(lightPrimaryColor),
  overlayColor: MaterialStateProperty.all(_primaryLightColor),
);

final _listTileTheme = ListTileThemeData(shape: roundedRectangleBorder30);

final _dialogTheme = DialogTheme(shape: roundedRectangleBorder30);

final _tooltipTheme = TooltipThemeData(
  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
  decoration: BoxDecoration(
    borderRadius: borderRadius15,
    color: _floatingActionButtonColor.withOpacity(0.9),
  ),
  textStyle: _textTheme.titleSmall,
);

final _appBarTheme = AppBarTheme(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomRight: Radius.circular(15),
      bottomLeft: Radius.circular(15),
    ),
  ),
  shadowColor: _shadowColor,
  iconTheme: const IconThemeData(color: _iconColorSecondary),
  color: _backgroundColor,
  elevation: 1.5,
  titleTextStyle: _textTheme.titleLarge,
);

const _floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: _floatingActionButtonColor,
  elevation: 0,
);

const _progressIndicatorTheme = ProgressIndicatorThemeData(
  refreshBackgroundColor: _primaryLightColor,
  circularTrackColor: _primaryLightColor,
  linearTrackColor: _primaryLightColor,
  color: lightPrimaryColor,
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    visualDensity: VisualDensity.compact,
    backgroundColor: lightPrimaryColor,
    textStyle: _textTheme.titleSmall,
    foregroundColor: Colors.white,
    shape: roundedRectangleBorder25,
  ),
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    side: const BorderSide(color: lightPrimaryColor, width: 1.5),
    visualDensity: VisualDensity.compact,
    foregroundColor: lightPrimaryColor,
    textStyle: _textTheme.titleSmall,
    shape: roundedRectangleBorder25,
  ),
);

const _textTheme = TextTheme(
  titleSmall: TextStyle(
    fontWeight: FontWeight.w700,
    color: _titleTextColor,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w700,
    color: _titleTextColor,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
    color: _titleTextColor,
  ),
  labelSmall: TextStyle(
    color: _bodyTextColor,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.7,
  ),
  labelMedium: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700),
  labelLarge: TextStyle(color: _bodyTextColor, fontWeight: FontWeight.w700),
  bodySmall: TextStyle(color: _bodyTextColor),
  bodyMedium: TextStyle(color: _bodyTextColor),
  bodyLarge: TextStyle(
      color: _bodyTextColor, fontSize: 16, fontWeight: FontWeight.w700),
  headlineLarge:
      TextStyle(fontWeight: FontWeight.w900, color: _headLineTextColor),
  headlineMedium:
      TextStyle(fontWeight: FontWeight.w900, color: _headLineTextColor),
  headlineSmall:
      TextStyle(fontWeight: FontWeight.w900, color: _headLineTextColor),
);

const _bottomNavBar = BottomNavigationBarThemeData(
  unselectedItemColor: _unselectedColor,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: lightPrimaryColor,
  showUnselectedLabels: true,
  elevation: 30,
  selectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w700,
    color: lightPrimaryColor,
    fontSize: 10,
  ),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w600,
    color: _unselectedColor,
    fontSize: 10,
  ),
);

const lightGradiants = [
  [Color(0xAA6A81A4), Color(0xFF6A81A4)],
  [Color(0xAAF0756B), Color(0xFFF0756B)],
  [Color(0xAAF4B183), Color(0xFFF4B183)],
  [Color(0xAA1B3A68), Color(0xFF1B3A68)],
  [Color(0xAAAACFB8), Color(0xFFAACFB8)],
];
