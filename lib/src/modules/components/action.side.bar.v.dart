import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/home/model/home.m.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../extensions/context.dart';
import '../../home/view/home.v.dart';
import 'code/provider/code.p.dart';

class ActionSideBar extends ConsumerWidget {
  const ActionSideBar({super.key, this.child, required this.module});

  final Widget? child;
  final Modules module;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: context.width * 0.2,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: context.height * 0.2,
                child: const AnimatedFlutter(),
              ),
              const SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: ref.read(codePageControllerProvider(module).notifier).execute,
                child: const Text('Execute'),
              ),
              const SizedBox(height: 8),
              Consumer(
                builder: (_, ref, __) {
                  ref.watch(codePageIndexProvider(module));
                  final function = ref.watch(codePageControllerProvider(module).notifier).title;
                  debugPrint('Function: $function');
                  final took = ref.watch(timeTookProvider(function));
                  if (took == null) return const SizedBox.shrink();
                  final tooks = took > 1000 ? '${took / 1000}s' : '${took}ms';
                  return Text('Took $tooks');
                },
              ),
              const SizedBox(height: 8),
              if (child != null) ...[child!, const SizedBox(height: 8)],
              const Spacer(),
              ActionBarPrevNextButtonView(module: module),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionBarPrevNextButtonView extends ConsumerWidget {
  const ActionBarPrevNextButtonView({super.key, required this.module});

  final Modules module;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(codePageIndexProvider(module));
    return Row(
      children: [
        Expanded(
          child: index == 0
              ? const SizedBox.shrink()
              : FilledButton.tonal(
                  onPressed: ref.read(codePageControllerProvider(module).notifier).animateToPrevious,
                  child: const Text('Previous'),
                ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: index == module.codes.length - 1
              ? const SizedBox.shrink()
              : FilledButton.tonal(
                  onPressed: ref.read(codePageControllerProvider(module).notifier).animateToNext,
                  child: const Text('Next'),
                ),
        ),
      ],
    );
  }
}
