import 'package:flutter/material.dart';
import '/src/modules/image_processing/providers/provider.dart'
    show imgFileProvider, loadingProvider;
import '/src/helper/constants/constants.dart' show assetsPath;
import '/src/helper/size_config.dart' show ScreenSize;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show ConsumerWidget, WidgetRef;

class AsyncImage extends ConsumerWidget {
  const AsyncImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(loadingProvider('asyncImage'));
    final file = ref.watch(imgFileProvider('asyncImage'));
    final fileNotifier = ref.watch(imgFileProvider('asyncImage').notifier);
    return Expanded(
      flex: 1,
      child: loading
          ? const Center(
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(strokeWidth: 10)))
          : file != null
              ? SizedBox(
                  width: ScreenSize.width,
                  height: ScreenSize.height,
                  child: Image.file(file))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () async =>
                        await fileNotifier.loadImg(ref, assetsPath),
                    child: const Text('Process Image Asynchronously '),
                  ),
                ),
    );
  }
}

class ThreadImage extends ConsumerWidget {
  const ThreadImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(loadingProvider('threadImage'));
    final file = ref.watch(imgFileProvider('threadImage'));
    final fileNotifier = ref.watch(imgFileProvider('threadImage').notifier);
    return Expanded(
      flex: 1,
      child: loading
          ? const Center(
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(strokeWidth: 10)))
          : file != null
              ? SizedBox(
                  width: ScreenSize.width,
                  height: ScreenSize.height,
                  child: Image.file(file))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () async =>
                        await fileNotifier.startThread(ref, assetsPath),
                    child: const Text('Process Image Asynchronously '),
                  ),
                ),
    );
  }
}
