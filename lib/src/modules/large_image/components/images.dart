import 'package:flutter/material.dart';
import '/src/helper/constants/constants.dart' show assetsPath;
import '/src/helper/size_config.dart' show ScreenSize;
import '/src/modules/large_image/providers/provider.dart' show imgFileProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class AsyncImage extends ConsumerWidget {
  const AsyncImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(imgFileProvider('asyncImage'));
    final fileNotifier = ref.watch(imgFileProvider('asyncImage').notifier);
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () async {
          await fileNotifier.loadImg(ref, assetsPath);
        },
        child: ColoredBox(
          color: Colors.green,
          child: SizedBox(
            width: ScreenSize.width,
            height: ScreenSize.height,
            child: file != null ? Image.file(file) : const SizedBox(),
          ),
        ),
      ),
    );
  }
}

class ThreadImage extends ConsumerWidget {
  const ThreadImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final file = ref.watch(imgFileProvider('threadImage'));
    final fileNotifier = ref.watch(imgFileProvider('threadImage').notifier);
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () async {
          await fileNotifier.startThread(ref, assetsPath);
        },
        child: ColoredBox(
          color: Colors.orange,
          child: SizedBox(
            width: ScreenSize.width,
            height: ScreenSize.height,
            child: file != null ? Image.file(file) : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
