import '/src/modules/reusable/models/screen.dart' show ScreenData;
import '/src/modules/reusable/repository/screen.dart'
    show alwaysAliveData, imageProcessingData, sharedPrefData;

enum Screens {
  sharedPref(screenData: sharedPrefData),
  alwaysAlive(screenData: alwaysAliveData),
  imageProcessing(screenData: imageProcessingData);

  final ScreenData screenData;
  const Screens({required this.screenData});
}

enum ScreenName {
  imageProcessing,
  sharedPref,
  alwaysAlive,
}

enum IsolateType {
  write,
  read,
}
