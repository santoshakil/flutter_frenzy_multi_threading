import '/src/modules/reusable/models/screen.dart' show ScreenData;
import '/src/modules/reusable/repository/screen.dart'
    show alwaysAliveData, sharedPrefData;

enum Screens {
  sharedPref(screenData: sharedPrefData),
  alwaysAlive(screenData: alwaysAliveData);

  final ScreenData screenData;
  const Screens({required this.screenData});
}

enum ScreenName {
  sharedPref,
  alwaysAlive,
}

enum IsolateType {
  write,
  read,
}
