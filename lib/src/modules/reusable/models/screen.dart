import 'package:flutter/material.dart';

import '/src/helper/enum/enums.dart' show ScreenName;

class ScreenData {
  final ScreenName screenName;
  final List<PreviewData> previewData;
  const ScreenData({required this.screenName, required this.previewData});

  @override
  bool operator ==(Object other) {
    return other is ScreenData &&
        other.screenName == screenName &&
        other.previewData == previewData;
  }

  @override
  int get hashCode => screenName.hashCode ^ previewData.hashCode;
}

class PreviewData {
  final String? title;
  final String? des;
  final String? path;
  final Widget? widget;
  const PreviewData(
      {required this.title,
      required this.des,
      required this.path,
      this.widget});

  @override
  bool operator ==(Object other) {
    return other is PreviewData &&
        other.title == title &&
        other.des == des &&
        other.path == path;
  }

  @override
  int get hashCode => title.hashCode ^ des.hashCode ^ path.hashCode;
}
