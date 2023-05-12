import '/src/helper/enum/enums.dart' show SharedPrefType;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AutoDisposeNotifierProvider, AutoDisposeNotifier;

final selectedSharedPrefTypeProvider =
    AutoDisposeNotifierProvider<_SharedPrefType, SharedPrefType>(
        _SharedPrefType.new);

class _SharedPrefType extends AutoDisposeNotifier<SharedPrefType> {
  @override
  SharedPrefType build() => SharedPrefType.init;

  void update(SharedPrefType v) => state = v;

  void next() {
    if (state == SharedPrefType.values.last) {
      state = SharedPrefType.values.first;
    } else {
      state = SharedPrefType.values[SharedPrefType.values.indexOf(state) + 1];
    }
  }
}
