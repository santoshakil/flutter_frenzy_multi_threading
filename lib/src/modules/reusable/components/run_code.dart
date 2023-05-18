import 'package:flutter/material.dart';
import '/src/modules/image_processing/providers/provider.dart'
    show imgFileProvider, loadingProvider;
import '/src/modules/reusable/providers/threads/always_alive.dart'
    show parseToAlwaysAliveThread;
import '/src/helper/enum/enums.dart' show IsolateType, ScreenName, Screens;
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
    final screen = ref.watch(selectedScreenProvider);
    if (screen == Screens.imageProcessing) return const SizedBox(height: 10);
    return CustomeMaterialButton(
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(.3),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      onPressed: () async {
        final selected = ref.read(selectedScreenProvider).screenData.screenName;
        if (ScreenName.sharedPref == selected) {
          await startSharedPrefThread();
        } else if (ScreenName.alwaysAlive == selected) {
          await parseToAlwaysAliveThread(
              [IsolateType.write, 'Write Something in Always Alive Thread']);
        } else if (ScreenName.imageProcessing == selected) {
          ref.invalidate(loadingProvider('asyncImage'));
          ref.invalidate(loadingProvider('threadImage'));
          ref.invalidate(imgFileProvider('asyncImage'));
          ref.invalidate(imgFileProvider('threadImage'));
        }
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
