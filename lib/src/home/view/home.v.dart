import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/home/model/home.m.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/home.p.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: PageView.builder(
        itemBuilder: (context, index) => Modules.values[index].view,
        controller: ref.watch(pageControllerProvider),
        itemCount: Modules.values.length,
      ),
    );
  }
}
