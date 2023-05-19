import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';

import 'package:ffi/ffi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../components/code/provider/code.p.dart';

const binaryPath = 'assets/bin/librust_dir_watcher.dylib';

typedef HashPathFFI = Pointer<Utf8> Function(
  Pointer<Utf8> sourcePath,
  Pointer<Utf8> destinationPath,
);

void ffiFuntion(Ref ref) async {
  final receivePort = ReceivePort();
  ref.read(executionRunningProvider.notifier).state = true;
  ref.read(executionMessageProvider.notifier).state = 'Hashing files...';
  final picker = FilePicker.platform;
  final sourcePath = await picker.getDirectoryPath();
  final destinationPath = await picker.getDirectoryPath();
  if (sourcePath == null || destinationPath == null) {
    ref.read(executionRunningProvider.notifier).state = false;
    ref.read(executionMessageProvider.notifier).state = 'No path selected';
    return;
  }

  final binaryFile = File('${(await getApplicationDocumentsDirectory()).path}/librust_dir_watcher.dylib');
  final binaryByteData = await rootBundle.load(binaryPath);
  final binary = binaryByteData.buffer.asUint8List();
  await binaryFile.writeAsBytes(binary);

  final isolate = await Isolate.spawn(
    (v) {
      final ffi = DynamicLibrary.open(v.$1);

      final hashPathFFI = ffi.lookupFunction<HashPathFFI, HashPathFFI>('hash_path_ffi');

      final sourcePathPointer = sourcePath.toNativeUtf8();
      final destinationPathPointer = destinationPath.toNativeUtf8();

      final result = hashPathFFI(sourcePathPointer, destinationPathPointer);

      v.$2.send(result.toDartString());

      calloc.free(sourcePathPointer);
      calloc.free(destinationPathPointer);
      calloc.free(result);
    },
    (binaryFile.path, receivePort.sendPort),
  );

  final message = await receivePort.first as String;
  ref.read(executionMessageProvider.notifier).state = message;
  ref.read(executionRunningProvider.notifier).state = false;
  isolate.kill();
}
