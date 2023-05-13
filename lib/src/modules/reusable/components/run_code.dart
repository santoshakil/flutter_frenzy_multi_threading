import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/components/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunCodeButton extends ConsumerWidget {
  const RunCodeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomeMaterialButton(
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.3),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      onPressed: () {},
      // onPressed: () async => await startSharedPrefThread(),
      child: Center(
        child: Text(
          'Run',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
