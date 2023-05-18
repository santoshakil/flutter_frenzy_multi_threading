import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    if (index == 0) return 'Welcome to Flutter Frenzy Multi-Threading';
    return Modules.values[index - 1].title;
  }

  void goTo(int index) {
    state.jumpToPage(index);
    final title = index == 0 ? 'Welcome to Flutter Frenzy Multi-Threading' : Modules.values[index - 1].title;
    ref.read(pageIndicatorProvider.notifier).state = index;
    ref.read(pageTitleProvider.notifier).state = title;
  }

  void goToNext() {
    if (index == Modules.values.length) return;
    goTo(index + 1);
    ref.read(pageTitleProvider.notifier).state = title;
    ref.read(pageIndicatorProvider.notifier).state = index;
  }

  void goToPrevious() {
    if (index == 0) return;
    goTo(index - 1);
    ref.read(pageTitleProvider.notifier).state = title;
    ref.read(pageIndicatorProvider.notifier).state = index;
  }
}
