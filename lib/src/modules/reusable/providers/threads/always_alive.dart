import 'dart:developer' show log;
import 'dart:isolate' show Isolate, ReceivePort, SendPort;

import 'package:flutter/foundation.dart' show debugPrint;
import '/src/helper/enum/enums.dart' show IsolateType;

final _receivePort = ReceivePort();
SendPort? _sendPort;

Future<void> activeAlwaysAliveThread() async {
  debugPrint('Isolate activeting');
  final isolate =
      await Isolate.spawn(_runActiveThread, [_receivePort.sendPort]);
  isolate.addOnExitListener(_receivePort.sendPort, response: 'Isolate exited');
  _receivePort.listen((message) {
    if (message is SendPort) _sendPort = message;
  });
  debugPrint('Isolate started:');
}

Future<void> _runActiveThread(List message) async {
  debugPrint('Isolate running $message');
  _sendPort = message[0] as SendPort;
  _sendPort!.send(_receivePort.sendPort);

  databaseConfigSync(); //? Database configuration (Sync)

  _receivePort.listen((messages) async {
    if (messages[0] is IsolateType && messages[0] == IsolateType.read) {
      await _readSomething();
    } else if (messages[0] is IsolateType && messages[0] == IsolateType.write) {
      await _writeSomething(messages[1] as String);
    }
  });
}

Future<void> parseToAlwaysAliveThread(List messages) async {
  try {
    if (_sendPort == null) {
      await activeAlwaysAliveThread();
      await Future.delayed(const Duration(milliseconds: 500));
    }
    _sendPort!.send(messages);
  } catch (e) {
    debugPrint(e.toString());
  }
}

void databaseConfigSync() {}
Future<void> _readSomething() async => log('Read Something');
Future<void> _writeSomething(String m) async => log(m);
