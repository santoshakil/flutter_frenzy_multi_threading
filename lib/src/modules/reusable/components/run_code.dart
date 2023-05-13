import 'package:flutter/material.dart';
import '/src/helper/enum/enums.dart' show ScreenName;
import '/src/modules/components/button.dart' show CustomeMaterialButton;
import '/src/modules/reusable/providers/provider.dart'
    show selectedScreenProvider;
import '/src/modules/reusable/providers/threads/shared_pref.dart'
    show startSharedPrefThread;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class RunCodeButton extends ConsumerWidget {
  const RunCodeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomeMaterialButton(
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.3),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      onPressed: () async {
        final selected =
            ref.watch(selectedScreenProvider).screenData.screenName;
        if (ScreenName.sharedPref == selected) {
          await startSharedPrefThread();
        } else if (ScreenName.alwaysAlive == selected) {}
      },
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
