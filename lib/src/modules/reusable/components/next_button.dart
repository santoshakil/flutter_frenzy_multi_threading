import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/components/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NextButton extends ConsumerWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomeMaterialButton(
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.3),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      padding: const EdgeInsets.all(10),
      onPressed: () {
        // ref.read(selectedSharedPrefTypeProvider.notifier).next();
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
