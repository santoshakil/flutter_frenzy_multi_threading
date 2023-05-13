import 'package:flutter/material.dart';
import '/src/helper/constants/colors/colors.dart' show white;
import '/src/helper/size_config.dart' show ScreenSize;
import '/src/modules/components/button.dart' show CustomeMaterialButton;
import '/src/modules/reusable/providers/provider.dart'
    show selectedButtonProvider, selectedScreenProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class OptionsList extends ConsumerWidget {
  const OptionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScreen = ref.watch(selectedScreenProvider);
    final selectedButton =
        ref.watch(selectedButtonProvider(selectedScreen.screenData.screenName));
    return Expanded(
      child: ListView.builder(
        itemCount: selectedScreen.screenData.previewData.length,
        itemBuilder: (cntext, index) {
          final data = selectedScreen.screenData.previewData[index];
          return CustomeMaterialButton(
            backgroundColor:
                white.withOpacity(selectedButton == data ? .2 : .05),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            onPressed: () => ref
                .read(
                    selectedButtonProvider(selectedScreen.screenData.screenName)
                        .notifier)
                .update(data),
            child: SizedBox(
              height: ScreenSize.height * .12,
              child: Center(
                child: Text(
                  data.title ?? data.des ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
