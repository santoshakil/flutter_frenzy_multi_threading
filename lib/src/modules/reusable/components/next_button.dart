import 'package:flutter/material.dart';
import '/src/modules/components/button.dart'  show CustomeMaterialButton;
import '/src/modules/reusable/providers/provider.dart'  show selectedButtonProvider, selectedScreenProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget, WidgetRef;

class NextButton extends ConsumerWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomeMaterialButton(
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.3),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      padding: const EdgeInsets.all(10),
      onPressed: () {
        final selectedScreen = ref.read(selectedScreenProvider);
        ref
            .read(selectedButtonProvider(selectedScreen.screenData.screenName)
                .notifier)
            .next();
      },
      child: Center(
        child: Text(
          'Next',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
