import 'package:flutter_frenzy_multi_threading/src/helper/enum/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedScreenProvider =
    NotifierProvider<_SelectedScreen, Screens>(_SelectedScreen.new);

class _SelectedScreen extends Notifier<Screens> {
  @override
  Screens build() => Screens.sharedPref;
}
