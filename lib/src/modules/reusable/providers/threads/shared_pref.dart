import 'dart:developer' show log;
import 'dart:isolate' show Isolate, ReceivePort, SendPort;
import 'dart:ui' show DartPluginRegistrant;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart'
    show BackgroundIsolateBinaryMessenger, RootIsolateToken, ServicesBinding;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

Future<void> startSharedPrefThread() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('data', 'Shared Pref Data');
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    _doSomethingInIsolate,
    [receivePort.sendPort, ServicesBinding.rootIsolateToken],
    onExit: receivePort.sendPort,
    onError: receivePort.sendPort,
  );
  isolate.addOnExitListener(receivePort.sendPort, response: 'Isolate exited');
  receivePort.listen((message) => debugPrint(message.toString()));
  debugPrint('Isolate Started:');
}

Future<void> _doSomethingInIsolate(List m) async {
  DartPluginRegistrant.ensureInitialized();
  BackgroundIsolateBinaryMessenger.ensureInitialized(
      m.last as RootIsolateToken);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? data = prefs.getString('data');
  debugPrint('Isolate running $m');
  log(data.toString());
  final sendPort = m[0] as SendPort;
  sendPort.send('Message');
}
