import 'package:flutter_frenzy_multi_threading/src/helper/enum/enums.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/reusable/models/screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedScreenProvider =
    NotifierProvider<_SelectedScreen, Screens>(_SelectedScreen.new);

class _SelectedScreen extends Notifier<Screens> {
  @override
  Screens build() => Screens.sharedPref;
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
