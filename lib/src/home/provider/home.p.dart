import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/home.m.dart';

final pageControllerProvider = NotifierProvider<PageNotifier, PageController>(PageNotifier.new);
final pageTitleProvider = StateProvider((_) => 'Welcome to Flutter Frenzy Multi-Threading');
final pageIndicatorProvider = StateProvider((_) => 0);

class PageNotifier extends Notifier<PageController> {
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

  Future<void> animateTo(int index) async {
    await state.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    final title = index == 0 ? 'Welcome to Flutter Frenzy Multi-Threading' : Modules.values[index - 1].title;
    ref.read(pageIndicatorProvider.notifier).state = index;
    ref.read(pageTitleProvider.notifier).state = title;
  }

  Future<void> animateToNext() async {
    if (index == Modules.values.length) return;
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
