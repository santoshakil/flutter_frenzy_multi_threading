import '/src/helper/enum/enums.dart' show SharedPrefTypes;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show AutoDisposeNotifierProvider, AutoDisposeNotifier;

final selectedSharedPrefTypeProvider =
    AutoDisposeNotifierProvider<_SharedPrefType, SharedPrefTypes>(
        _SharedPrefType.new);

class _SharedPrefType extends AutoDisposeNotifier<SharedPrefTypes> {
  @override
  SharedPrefTypes build() => SharedPrefTypes.init;

  void update(SharedPrefTypes v) => state = v;

  void next() {
    if (state == SharedPrefTypes.values.last) {
      state = SharedPrefTypes.values.first;
    } else {
      state = SharedPrefTypes.values[SharedPrefTypes.values.indexOf(state) + 1];
    }
  }
}
