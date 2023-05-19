import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/components/code/provider/code.p.dart';
import '../model/home.m.dart';

final pageControllerProvider = NotifierProvider<_PageNotifier, PageController>(_PageNotifier.new);
final pageTitleProvider = StateProvider((_) => 'Welcome to Flutter Frenzy Multi-Threading');
final pageIndicatorProvider = StateProvider((_) => 0);

class _PageNotifier extends Notifier<PageController> {
  @override
  PageController build() {
    final controller = PageController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }

  int get index => state.hasClients ? state.page!.toInt() : 0;

  String get title {
    if (index == 0 || index == 1) return 'Welcome to Flutter Frenzy Multi-Threading';
    if (index == Modules.values.length + 2) return 'Thank you for joining us!';
    return Modules.values[index - 2].title;
  }

  Future<void> animateTo(int index) async {
    if (index == this.index) return;
    ref.invalidate(executionMessageProvider);
    await state.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    final title = index == 0 || index == 1
        ? 'Welcome to Flutter Frenzy Multi-Threading'
        : index == Modules.values.length + 2
            ? 'Thank you for joining us!'
            : Modules.values[index - 2].title;
    ref.read(pageIndicatorProvider.notifier).state = index;
    ref.read(pageTitleProvider.notifier).state = title;
  }

  Future<void> animateToNext() async {
    if (index == Modules.values.length + 2) return;
    await animateTo(index + 1);
    ref.read(pageTitleProvider.notifier).state = title;
    ref.read(pageIndicatorProvider.notifier).state = index;
  }

  Future<void> animateToPrevious() async {
    if (index == 0) return;
    await animateTo(index - 1);
    ref.read(pageTitleProvider.notifier).state = title;
    ref.read(pageIndicatorProvider.notifier).state = index;
  }
}
