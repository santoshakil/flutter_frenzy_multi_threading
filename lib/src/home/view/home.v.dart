import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/extensions/context.dart';
import 'package:flutter_frenzy_multi_threading/src/home/model/home.m.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/home.p.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('HomeView.build');
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (_, ref, __) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                ref.watch(pageTitleProvider),
                key: ValueKey(ref.watch(pageTitleProvider)),
              ),
            );
          },
        ),
      ),
      body: PageView(
        controller: ref.watch(pageControllerProvider),
        children: [
          const HomeIntroView(key: Key('HomeIntroView')),
          for (final module in Modules.values) module.view,
        ],
      ),
    );
  }
}

class HomeIntroView extends ConsumerWidget {
  const HomeIntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: Modules.values.length,
      itemBuilder: (_, index) {
        final module = Modules.values[index];
        return HomeIntroTile(key: ValueKey(module), module: module);
      },
    );
  }
}

class HomeIntroTile extends StatelessWidget {
  const HomeIntroTile({super.key, required this.module});

  final Modules module;

  @override
  Widget build(BuildContext context) {
    final padding = context.width * 0.02;
    return Card(
      margin: EdgeInsets.fromLTRB(padding, padding * 0.7, padding, 0),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(module.title, style: context.text.headlineLarge),
            const SizedBox(height: 10),
            Text(module.description, style: context.text.titleMedium),
          ],
        ),
      ),
    );
  }
}
