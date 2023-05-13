import 'package:flutter_frenzy_multi_threading/src/modules/reusable/models/screen.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/reusable/repository/screen.dart';

enum SharedPrefTypes {
  init(title: null, des: 'Shared Preference in Isolate', path: null),
  setup(
      title: 'Code Preview',
      des: null,
      path: 'assets/images/shared_pref_init.png'),
  error(
      title: 'Error',
      des:
          '[Bad state: The BackgroundIsolateBinaryMessenger.instance value is invalid until BackgroundIsolateBinaryMessenger.ensureInitialized is executed., #0      BackgroundIsolateBinaryMessenger.instance',
      path: null),
  fix(
      title: 'How can we fix this?',
      des: null,
      path: 'assets/images/shared_pref_final.png');

  final String? title;
  final String? des;
  final String? path;
  const SharedPrefTypes(
      {required this.title, required this.des, required this.path});
}

enum Screens {
  sharedPref(screenData: sharedPrefData);

  final ScreenData screenData;
  const Screens({required this.screenData});
}

enum ScreenName {
  sharedPref,
  alwaysAlive,
}
