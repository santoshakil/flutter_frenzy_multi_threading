import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synchronized/synchronized.dart';

void withoutCompute(Ref ref) => _task();

Future<void> withCompute(Ref ref) async => await compute(_task, 0);

void _task([int x = 0]) {
  for (var i = 0; i < 10000000000; i++) {
    x++;
  }
}

// ........................................................................... //

void withoutIsolate(Ref ref) async {
  await processImageFromByteData(await rootBundle.load('assets/images/IMG_20230514_215912.jpg'));
}

Future<void> withIsolate(Ref ref) async {
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
}

Future<void> processImageFromByteData(ByteData? byteData) async {
  // .... //
}

// ........................................................................... //

final receivePort = ReceivePort();
SendPort? sendPort;

void openPersistantThread(Ref ref) async {
  // .... //
}

void persistantThread(SendPort p) async {
  sendPort = p;
  sendPort!.send(receivePort.sendPort);

  receivePort.listen((v) async {
    if (v == 'EXIT') {
      sendPort!.send('EXIT');
      Isolate.current.kill();
      return;
    }

    if (v is int) {
      // .... //
    }

    if (v is (ByteData, RootIsolateToken)) {
      // .... //
    }
  });
}

void pushIntToPersistantThread(Ref ref) {
  if (sendPort == null) return;
  sendPort!.send(5000000000);
}

Future<void> pushByteDataToPersistantThread(Ref ref) async {
  if (sendPort == null) return;
  sendPort!.send((
    await rootBundle.load('assets/images/IMG_20230514_215912.jpg'),
    ServicesBinding.rootIsolateToken!,
  ));
}

void exitPersistantThread(Ref ref) {
  if (sendPort == null) return;
  sendPort!.send('EXIT');
}

// ........................................................................... //

void withoutSynchronization(Ref ref) async {
  compute(_task2, null);
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> _task2(_) async => await Future.delayed(const Duration(seconds: 2));

final _lock = Lock();

void wihtSynchronization(Ref ref) async {
  await _lock.synchronized(() async {
    await compute(_task2, null);
    await Future.delayed(const Duration(seconds: 1));
  });
}

// ........................................................................... //

// typedef HashPathFFI = Pointer<Utf8> Function(Pointer<Utf8> sourcePath, Pointer<Utf8> destinationPath);

// void ffiFuntion(Ref ref) async {
//   // .... //
//   final isolate = await Isolate.spawn(
//     (v) {
//       final ffi = DynamicLibrary.open(v.$1);
//       final hashPathFFI = ffi.lookupFunction<HashPathFFI, HashPathFFI>('hash_path_ffi');
//       final result = hashPathFFI(sourcePathPointer, destinationPathPointer);
//       calloc.free(sourcePathPointer);
//       // .... //
//     },
//     (binaryFile.path, receivePort.sendPort),
//   );
//   // .... //
// }

// #[no_mangle]
// pub extern "C" fn hash_path_ffi(source_path: *const c_char, destination_path: *const c_char) -> *const c_char {
//     // .... //
//     let (sender, receiver) = channel::<HashSet<(String, String)>>();
//     let sender_clone = sender.clone();
//     _ = thread::spawn(move || { .... });

//     let source_thread = thread::spawn(move || hash_path(&source_path, sender));
//     let dest_thread = thread::spawn(move || hash_path(&dest_path, sender_clone));

//     _ = source_thread.join().unwrap().unwrap();
//     // .... //
// }
