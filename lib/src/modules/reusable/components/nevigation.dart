import 'package:flutter/material.dart';
import '/src/modules/reusable/providers/provider.dart'
    show selectedScreenProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class NavigationButtons extends ConsumerWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = ref.watch(selectedScreenProvider.notifier);
    return ColoredBox(
      color: Theme.of(context).colorScheme.secondary.withOpacity(.3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: () => screen.previous(),
              padding: const EdgeInsets.all(12),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: const Text('Previous'),
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              onPressed: () => screen.next(),
              padding: const EdgeInsets.all(12),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
