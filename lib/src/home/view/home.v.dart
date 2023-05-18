import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/extensions/context.dart';
import 'package:flutter_frenzy_multi_threading/src/home/model/home.m.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/home.p.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const BackwardButton(key: Key('HomeIntroBackwardButton')),
            Expanded(
              child: Consumer(
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
            const ForwardButton(key: Key('HomeIntroForwardButton')),
          ],
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
    );
  }
}

class HomeIntroView extends ConsumerWidget {
  const HomeIntroView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = context.width * 0.02;
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: List.generate(
          Modules.values.length,
          (index) {
            final module = Modules.values[index];
            return Expanded(
              child: Column(
                children: [
                  Expanded(child: HomeIntroTile(key: ValueKey(module), module: module)),
                  if (index != Modules.values.length - 1) const SizedBox(height: 10),
                ],
              ),
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
    return ListTile(
      tileColor: context.colors.onPrimary,
      leading: Text(
        (module.index + 1).toString(),
        style: context.text.headlineLarge!.copyWith(
          color: context.colors.primary,
          fontWeight: FontWeight.w900,
        ),
      ),
      title: Text(module.title, style: context.text.headlineLarge),
      subtitle: Text(module.description, style: context.text.titleMedium),
      onTap: () {},
    );
  }
}

class ForwardButton extends ConsumerWidget {
  const ForwardButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 40,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        child: ref.watch(pageIndicatorProvider) == Modules.values.length
            ? const SizedBox.shrink()
            : IconButton.filledTonal(
                onPressed: ref.read(pageControllerProvider.notifier).animateToNext,
                icon: const Icon(Icons.arrow_forward),
              ),
      ),
    );
  }
}

class BackwardButton extends ConsumerWidget {
  const BackwardButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 40,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        child: ref.watch(pageIndicatorProvider) == 0
            ? const SizedBox.shrink()
            : IconButton.filledTonal(
                onPressed: ref.read(pageControllerProvider.notifier).animateToPrevious,
                icon: const Icon(Icons.arrow_back),
              ),
      ),
    );
  }
}
