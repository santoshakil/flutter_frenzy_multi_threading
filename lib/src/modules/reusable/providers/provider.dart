import '/src/helper/enum/enums.dart' show ScreenName, Screens;
import '/src/modules/reusable/models/screen.dart' show PreviewData;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show
        AutoDisposeFamilyNotifier,
        AutoDisposeNotifierProviderFamily,
        Notifier,
        NotifierProvider;

final selectedScreenProvider =
    NotifierProvider<_SelectedScreen, Screens>(_SelectedScreen.new);

class _SelectedScreen extends Notifier<Screens> {
  @override
  Screens build() => Screens.imageProcessing;
}

final selectedButtonProvider =
    AutoDisposeNotifierProviderFamily<_SelectedButton, PreviewData, ScreenName>(
        _SelectedButton.new);

class _SelectedButton
    extends AutoDisposeFamilyNotifier<PreviewData, ScreenName> {
  @override
  PreviewData build(ScreenName arg) =>
      ref.read(selectedScreenProvider).screenData.previewData.first;

  void update(PreviewData data) => state = data;

  void next() {
    final list = ref.read(selectedScreenProvider).screenData.previewData;

    if (state == list.last) {
      state = list.first;
    } else {
      state = list[list.indexOf(state) + 1];
    }
  }
}
