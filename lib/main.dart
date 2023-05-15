import 'dart:ui';

import 'package:flutter/material.dart';

import 'src/main_app.dart' show MainApp;
import 'src/modules/reusable/providers/threads/always_alive.dart'
    show activeAlwaysAliveThread;

Future<void> main() async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await activeAlwaysAliveThread();
  runApp(const MainApp());
}
