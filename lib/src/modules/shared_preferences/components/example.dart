import 'package:flutter/material.dart';
import '/src/helper/constants/colors/colors.dart' show white;
import '/src/helper/enum/enums.dart' show SharedPrefTypes;
import '/src/helper/size_config.dart' show ScreenSize;
import '/src/modules/components/button.dart' show CustomeMaterialButton;
import '/src/modules/shared_preferences/providers/provider.dart'
    show selectedSharedPrefTypeProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class TopicsExamples extends ConsumerWidget {
  const TopicsExamples({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(selectedSharedPrefTypeProvider);
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: ListView.builder(
        itemCount: SharedPrefTypes.values.length,
        itemBuilder: (cntext, index) {
          final data = SharedPrefTypes.values[index];
          return CustomeMaterialButton(
            backgroundColor: white.withOpacity(selectedType == data ? .2 : .05),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            onPressed: () {
              ref.read(selectedSharedPrefTypeProvider.notifier).update(data);
            },
            child: SizedBox(
              height: ScreenSize.height * .12,
              child: Center(
                child: Text(
                  data.title ?? data.des ?? '',
                  textAlign: TextAlign.center,
                  style: textTheme.labelMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
