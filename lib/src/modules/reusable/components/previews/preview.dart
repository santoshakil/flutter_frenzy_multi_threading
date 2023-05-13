import 'package:flutter/material.dart';
import '/src/helper/size_config.dart' show ScreenSize;
import '/src/modules/reusable/providers/provider.dart'
    show selectedButtonProvider, selectedScreenProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Consumer, ConsumerWidget, WidgetRef;

class PreviewPanel extends ConsumerWidget {
  const PreviewPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColoredBox(
            color: Colors.black38,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Consumer(builder: (context, ref, __) {
                    final selectedScreen = ref.watch(selectedScreenProvider);
                    final selectedData = ref.watch(selectedButtonProvider(
                        selectedScreen.screenData.screenName));
                    return Text(
                      selectedData.title ?? '',
                      style: textTheme.labelLarge,
                    );
                  }),
                ),
                _SharedPrefPreview(textTheme: textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SharedPrefPreview extends ConsumerWidget {
  const _SharedPrefPreview({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScreen = ref.watch(selectedScreenProvider);
    final selectedData =
        ref.watch(selectedButtonProvider(selectedScreen.screenData.screenName));

    return Expanded(
        child: Stack(
      children: [
        for (final e in selectedScreen.screenData.previewData)
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: selectedData == e ? 1 : 0,
              curve: Curves.easeIn,
              child: SizedBox(
                width: ScreenSize.width,
                height: ScreenSize.height,
                child: e.path != null
                    ? Image.asset(
                        e.path!,
                        fit: BoxFit.contain,
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            e.des ?? '',
                            textAlign: TextAlign.center,
                            style: textTheme.labelLarge!.copyWith(
                              color: e.title == 'Error' ? Colors.red : null,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
      ],
    ));
  }
}
