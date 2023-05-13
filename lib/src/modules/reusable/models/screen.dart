import '/src/helper/enum/enums.dart' show ScreenName;

class ScreenData {
  final ScreenName screenName;
  final List<PreviewData> previewData;
  const ScreenData({required this.screenName, required this.previewData});
}

class PreviewData {
  final String? title;
  final String? des;
  final String? path;
  const PreviewData(
      {required this.title, required this.des, required this.path});
}
