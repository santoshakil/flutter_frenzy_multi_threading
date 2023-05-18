import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../home/model/home.m.dart';

final codePageControllerProvider = NotifierProvider.family<_PageNotifier, PageController, Modules>(_PageNotifier.new);

class _PageNotifier extends FamilyNotifier<PageController, Modules> {
  @override
  PageController build(Modules arg) {
    final controller = PageController();
    ref.onDispose(() => controller.dispose());
    return controller;
  }

  int get index => state.hasClients ? state.page!.toInt() : 0;

  String get title => arg.codes.keys.elementAt(index);

  Function get function => arg.codes.values.elementAt(index);

  Future<void> animateTo(int index) async =>
      await state.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

  Future<void> animateToNext() async {
    if (index == arg.codes.length - 1) return;
    await animateTo(index + 1);
  }

  Future<void> animateToPrevious() async {
    if (index == 0) return;
    await animateTo(index - 1);
  }
}
