import 'package:flutter/material.dart';
import 'helper/size_config.dart';
import 'modules/shared_preferences/shared_preferences.dart'
    show SharedPreferencesScreen;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;

// import 'modules/home/home.dart' show HomeScreen;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          ScreenSize().init(context);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: 1.0, devicePixelRatio: 1.0),
              child: child!);
        },
        // home: const HomeScreen(),
        home: const SharedPreferencesScreen(),
      ),
    );
  }
}
