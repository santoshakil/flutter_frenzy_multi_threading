import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/home.m.dart';

final pageControllerProvider = NotifierProvider<PageNotifier, PageController>(PageNotifier.new);
final pageTitleProvider = StateProvider((_) => 'Welcome to Flutter Frenzy Multi-Threading');

class PageNotifier extends Notifier<PageController> {
  @override
  PageController build() {
    final controller = PageController();
    ref.onDispose(() => controller.dispose());
    controller.addListener(() => ref.read(pageTitleProvider.notifier).state = title);
    return controller;
  }

  int get index => state.hasClients ? state.page!.toInt() : 0;

  String get title {
    if (index == 0) return 'Welcome to Flutter Frenzy Multi-Threading';
    return Modules.values[index - 1].title;
  }
}
