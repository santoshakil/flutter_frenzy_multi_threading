import 'package:flutter/material.dart';
import '/src/modules/shared_preferences/providers/thread.dart'
    show startSharedPrefThread;
import '/src/modules/components/button.dart' show CustomeMaterialButton;
import '/src/modules/shared_preferences/providers/provider.dart'
    show selectedSharedPrefTypeProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;
import '/src/helper/constants/colors/colors.dart' show white;
import '/src/helper/size_config.dart' show ScreenSize;
import 'example.dart' show TopicsExamples;

class TopicsPanel extends ConsumerWidget {
  const TopicsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: ScreenSize.width * .2,
      // height: ScreenSize.height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 40, 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColoredBox(
            color: white.withOpacity(.05),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Examples',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const TopicsExamples(),
                CustomeMaterialButton(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(.3),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    ref.read(selectedSharedPrefTypeProvider.notifier).next();
                  },
                  child: Center(
                    child: Text(
                      'Next',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                CustomeMaterialButton(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondary.withOpacity(.3),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  onPressed: () async => await startSharedPrefThread(),
                  child: Center(
                    child: Text(
                      'Run',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
