import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

const binaryPath = 'assets/bin/librust_dir_watcher.dylib';

typedef HashPathFFI = Pointer<Utf8> Function(
  Pointer<Utf8> sourcePath,
  Pointer<Utf8> destinationPath,
);

void ffiFuntion(Ref ref) async {
  final picker = FilePicker.platform;
  final sourcePath = await picker.getDirectoryPath();
  final destinationPath = await picker.getDirectoryPath();
  if (sourcePath == null || destinationPath == null) return;

  final binaryFile = File('${(await getApplicationDocumentsDirectory()).path}/librust_dir_watcher.dylib');
  final binaryByteData = await rootBundle.load(binaryPath);
  final binary = binaryByteData.buffer.asUint8List();
  await binaryFile.writeAsBytes(binary);

  final ffi = DynamicLibrary.open(binaryFile.path);

  final hashPathFFI = ffi.lookupFunction<HashPathFFI, HashPathFFI>('hash_path_ffi');

  final sourcePathPointer = sourcePath.toNativeUtf8();
  final destinationPathPointer = destinationPath.toNativeUtf8();

  final result = hashPathFFI(sourcePathPointer, destinationPathPointer);

  final message = result.toDartString();

  debugPrint(message);

  calloc.free(sourcePathPointer);
  calloc.free(destinationPathPointer);
  calloc.free(result);
}
