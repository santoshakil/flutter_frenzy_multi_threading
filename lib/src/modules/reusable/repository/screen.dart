import '/src/helper/enum/enums.dart' show ScreenName;
import '/src/modules/reusable/models/screen.dart' show ScreenData, PreviewData;

const sharedPrefData = ScreenData(
  screenName: ScreenName.sharedPref,
  previewData: [
    PreviewData(title: null, des: 'Shared Preference in Isolate', path: null),
    PreviewData(
        title: 'Code Preview',
        des: null,
        path: 'assets/images/shared_pref_init.png'),
    PreviewData(
        title: 'Error',
        des:
            '[Bad state: The BackgroundIsolateBinaryMessenger.instance value is invalid until BackgroundIsolateBinaryMessenger.ensureInitialized is executed., #0      BackgroundIsolateBinaryMessenger.instance',
        path: null),
    PreviewData(
        title: 'How can we fix this?',
        des: null,
        path: 'assets/images/shared_pref_final.png')
  ],
);

const alwaysAliveData = ScreenData(
  screenName: ScreenName.alwaysAlive,
  previewData: [
    PreviewData(title: null, des: 'Always Alive Thread', path: null),
    PreviewData(
        title: 'Code Preview',
        des: null,
        path: null),
    PreviewData(
        title: 'Error',
        des:
            null,
        path: null),
    PreviewData(
        title: 'How can we fix this?',
        des: null,
        path:null)
  ],
);
