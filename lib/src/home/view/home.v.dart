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
        physics: const NeverScrollableScrollPhysics(),
        controller: ref.watch(pageControllerProvider),
        children: [
          const HomeIntroView(key: Key('HomeIntroView')),
          for (final module in Modules.values) module.view,
        ],
      ),
      floatingActionButton: const HomeIntroFloatingButton(key: Key('HomeIntroFloatingButton')),
    );
  }
}

class HomeIntroView extends ConsumerWidget {
  const HomeIntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = context.width * 0.05;
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 16, padding, padding),
      child: Column(
        children: List.generate(
          Modules.values.length,
          (index) {
            final module = Modules.values[index];
            return Expanded(
              child: HomeIntroTile(key: ValueKey(module), module: module),
            );
          },
        ),
      ),
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
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(module.title, style: context.text.headlineLarge),
            const SizedBox(height: 10),
            Text(
              module.description,
              style: context.text.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeIntroFloatingButton extends ConsumerWidget {
  const HomeIntroFloatingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
          child: ref.watch(pageIndicatorProvider) == 0
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  onPressed: ref.read(pageControllerProvider.notifier).animateToPrevious,
                  child: const Icon(Icons.arrow_back),
                ),
        ),
        const SizedBox(width: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
          child: ref.watch(pageIndicatorProvider) == Modules.values.length
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  onPressed: ref.read(pageControllerProvider.notifier).animateToNext,
                  child: const Icon(Icons.arrow_forward),
                ),
        ),
      ],
    );
  }
}
