import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        CrossAxisAlignment,
        Divider,
        MainAxisAlignment,
        MainAxisSize,
        MediaQuery,
        MediaQueryData,
        Orientation,
        SizedBox;

import 'constants/colors/colors.dart';



//Must be called on Initialization
class ScreenSize {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double defaultSize;
  static late double fontSize;
  static late double statusBarHeight;
  static late Orientation orientation;
  static late bool isPhone;
  static late double txtSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    fontSize = MediaQuery.of(context).textScaleFactor;
    isPhone = width < 650;
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    txtSize = 22 - (7 * ScreenSize.fontSize);
  }
}

MainAxisAlignment mainStart = MainAxisAlignment.start;
MainAxisAlignment mainCenter = MainAxisAlignment.center;
MainAxisSize mainMax = MainAxisSize.max;
MainAxisSize mainMin = MainAxisSize.min;

CrossAxisAlignment crossStart = CrossAxisAlignment.start;
CrossAxisAlignment crossCenter = CrossAxisAlignment.center;
CrossAxisAlignment crossStretch = CrossAxisAlignment.stretch;

///?
final divider5 = Divider(height: 5, color: black);
final divider2 = Divider(height: 2, thickness: .2, color: black);
final divider10 = Divider(height: 10, thickness: .2, color: black);

final dividerWhite5 = Divider(height: 5, color: white);
final dividerWhite2 = Divider(height: 2, thickness: .2, color: white);
final dividerWhite10 = Divider(height: 10, thickness: .2, color: white);

///?
const sizedBox5 = SizedBox(height: 5);
const sizedBox10 = SizedBox(height: 10);
const sizedBox20 = SizedBox(height: 20);
const sizedBox50 = SizedBox(height: 50);
const sizedBox80 = SizedBox(height: 80);

///?
final radius5 = BorderRadius.circular(5);
final radius8 = BorderRadius.circular(8);
final radius10 = BorderRadius.circular(10);
final radius12 = BorderRadius.circular(12);
final radius15 = BorderRadius.circular(15);
final radius20 = BorderRadius.circular(20);
final radius25 = BorderRadius.circular(25);
final radius50 = BorderRadius.circular(50);
final radius100 = BorderRadius.circular(100);
final radius200 = BorderRadius.circular(200);
