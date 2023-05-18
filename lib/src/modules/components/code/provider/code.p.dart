import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../home/model/home.m.dart';

final codePageControllerProvider =
    NotifierFamilyProvider.autoDispose<_PageNotifier, PageController, Modules>(_PageNotifier.new);
final codePageIndexProvider = StateProvider.family.autoDispose<int, Modules>((_, __) => 0);
// final timeTookProvider = StateProvider.family.autoDispose<int?, String>((_, __) => null);

class _PageNotifier extends AutoDisposeFamilyNotifier<PageController, Modules> {
  @override
  PageController build(Modules arg) {
    final controller = PageController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }

  // int get index => state.hasClients ? state.page?.toInt() ?? 0 : 0;
  int get index => ref.read(codePageIndexProvider(arg));

  String get title => arg.codes.keys.elementAt(index);

  Function get function => arg.codes.values.elementAt(index);

  void execute() async {
    // final timer = Stopwatch()..start();
    if (function is Future Function()) {
      await function();
    } else {
      function();
    }
    // timer.stop();
    // ref.read(timeTookProvider(title).notifier).state = timer.elapsedMilliseconds;
    // debugPrint('Execution time: ${timer.elapsedMilliseconds}ms');
  }

  Future<void> animateTo(int index) async {
    if (index == this.index) return;
    ref.read(codePageIndexProvider(arg).notifier).state = index;
    await state.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> animateToNext() async {
    if (index == arg.codes.length - 1) return;
    ref.read(codePageIndexProvider(arg).notifier).state = index;
    await animateTo(index + 1);
  }

  Future<void> animateToPrevious() async {
    if (index == 0) return;
    ref.read(codePageIndexProvider(arg).notifier).state = index;
    await animateTo(index - 1);
  }
}
