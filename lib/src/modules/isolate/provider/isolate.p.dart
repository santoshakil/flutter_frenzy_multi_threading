import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../components/code/provider/code.p.dart';

void withoutIsolate(Ref ref) async {
  ref.read(executionRunningProvider.notifier).state = true;
  final timer = Stopwatch()..start();
  await _task(await rootBundle.load('assets/images/IMG_20230514_215912.jpg'));
  timer.stop();
  ref.read(executionMessageProvider.notifier).state = 'Took: ${timer.elapsedMilliseconds}ms';
  ref.read(executionRunningProvider.notifier).state = false;
}

Future<void> withIsolate(Ref ref) async {
  ref.read(executionRunningProvider.notifier).state = true;
  final timer = Stopwatch()..start();
  final port = ReceivePort();
  final isolate = await Isolate.spawn(
    (v) async {
      DartPluginRegistrant.ensureInitialized();
      BackgroundIsolateBinaryMessenger.ensureInitialized(v.$2);
      await _task(v.$1);
      v.$3.send(true);
    },
    (
      await rootBundle.load('assets/images/IMG_20230514_215912.jpg'),
      ServicesBinding.rootIsolateToken!,
      port.sendPort,
    ),
  );
  await port.first;
  isolate.kill();
  timer.stop();
  ref.read(executionMessageProvider.notifier).state = 'Took: ${timer.elapsedMilliseconds}ms';
  ref.read(executionRunningProvider.notifier).state = false;
}

Future<void> _task(ByteData? byteData) async {
  try {
    final image = byteData ?? await rootBundle.load('assets/images/IMG_20230514_215912.jpg');
    Uint8List imageData = image.buffer.asUint8List();
    final file = await File('${(await getTemporaryDirectory()).path}/image.jpg').writeAsBytes(imageData);
    final fileBytes = await file.readAsBytes();
    final uint8List = Uint8List.fromList(fileBytes);
    const fileName = 'image.jpg';
    final image2 = img.decodeImage(uint8List);
    img.billboard(image2!, grid: 10, amount: 1, maskChannel: img.Channel.luminance);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    File imageFile = File(filePath);
    imageFile = await imageFile.writeAsBytes(img.encodeJpg(image2));
    debugPrint('Image conversion complete.');
  } catch (e) {
    debugPrint('Error: $e');
  }
}
