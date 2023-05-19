import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/code/provider/code.p.dart';
import '../../isolate/provider/isolate.p.dart';

final receivePort = ReceivePort();
SendPort? sendPort;

void openPersistantThread(Ref ref) async {
  if (sendPort != null) {
    ref.read(executionMessageProvider.notifier).state = 'Persistant thread already opened!!!';
    return;
  }

  ref.read(executionRunningProvider.notifier).state = true;
  ref.read(executionMessageProvider.notifier).state = 'Opening persistant thread...';

  final isolate = await Isolate.spawn(_persistantThread, receivePort.sendPort);

  ref.read(executionMessageProvider.notifier).state = 'Persistant thread opened!!!';
  ref.read(executionRunningProvider.notifier).state = false;

  await for (final v in receivePort) {
    if (v is String) ref.read(executionMessageProvider.notifier).state = v;
    if (v is SendPort) sendPort = v;
    if (v == 'EXIT') {
      isolate.kill();
      sendPort = null;
      ref.read(executionMessageProvider.notifier).state = 'Persistant thread closed!!!';
      break;
    }
  }
}

void pushIntToPersistantThread(Ref ref) {
  if (sendPort == null) {
    ref.read(executionMessageProvider.notifier).state = 'Persistant thread not opened!!!';
    return;
  }
  sendPort!.send(5000000000);
  ref.read(executionMessageProvider.notifier).state = 'Sent int to persistant thread!!!';
}

Future<void> pushByteDataToPersistantThread(Ref ref) async {
  if (sendPort == null) {
    ref.read(executionMessageProvider.notifier).state = 'Persistant thread not opened!!!';
    return;
  }
  ref.read(executionRunningProvider.notifier).state = true;
  ref.read(executionMessageProvider.notifier).state = 'Sending image data to persistant thread...';

  sendPort!.send((
    await rootBundle.load('assets/images/IMG_20230514_215912.jpg'),
    ServicesBinding.rootIsolateToken!,
  ));

  ref.read(executionMessageProvider.notifier).state = 'Image data sent to persistant thread!!!';
  ref.read(executionRunningProvider.notifier).state = false;
}

void exitPersistantThread(Ref ref) {
  if (sendPort == null) {
    ref.read(executionMessageProvider.notifier).state = 'Persistant thread not opened!!!';
    return;
  }
  sendPort!.send('EXIT');
}

void _persistantThread(SendPort p) async {
  sendPort = p;
  sendPort!.send(receivePort.sendPort);

  receivePort.listen((v) async {
    if (v == 'EXIT') {
      sendPort!.send('EXIT');
      Isolate.current.kill();
      return;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    debugPrint(now.toString());

    if (v is int) {
      sendPort!.send('$now\nIterating $v times in persistant thread...');
      int x = 0;
      for (var i = 0; i < v; i++) {
        x++;
      }
      sendPort!.send('$now\nIterated $x times in persistant thread');
    }

    if (v is (ByteData, RootIsolateToken)) {
      sendPort!.send('$now\nProcessing image in persistant thread...');
      DartPluginRegistrant.ensureInitialized();
      BackgroundIsolateBinaryMessenger.ensureInitialized(v.$2);
      await processImageFromByteData(v.$1);
      sendPort!.send('$now\nImage processed in persistant thread!!!');
    }
  });
}
