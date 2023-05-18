import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/extensions/context.dart';
import 'src/home/view/home.v.dart';
import 'src/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: _App(key: Key('_App'))));
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(data: context.mq, child: child!),
      home: const HomeView(key: Key('HomeView')),
      debugShowCheckedModeBanner: false,
      theme: defaultDarkTheme,
    );
  }
}
