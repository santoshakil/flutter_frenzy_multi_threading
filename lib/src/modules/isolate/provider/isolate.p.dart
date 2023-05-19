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
  ref.read(executionMessageProvider.notifier).state = 'Processing image...';
  await processImageFromByteData(await rootBundle.load('assets/images/IMG_20230514_215912.jpg'));
  ref.read(executionMessageProvider.notifier).state = 'Image processed!!!';
  ref.read(executionRunningProvider.notifier).state = false;
}

Future<void> withIsolate(Ref ref) async {
  ref.read(executionRunningProvider.notifier).state = true;
  ref.read(executionMessageProvider.notifier).state = 'Processing image...';
  final port = ReceivePort();
  final isolate = await Isolate.spawn(
    (v) async {
      DartPluginRegistrant.ensureInitialized();
      BackgroundIsolateBinaryMessenger.ensureInitialized(v.$2);
      await processImageFromByteData(v.$1);
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
  ref.read(executionMessageProvider.notifier).state = 'Image processed!!!';
  ref.read(executionRunningProvider.notifier).state = false;
}

Future<void> processImageFromByteData(ByteData? byteData) async {
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
