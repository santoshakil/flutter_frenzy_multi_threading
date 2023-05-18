import 'package:flutter/material.dart';
import 'helper/size_config.dart' show ScreenSize;
import 'modules/reusable/reusable.dart' show ReusableScreen;
import 'package:flutter_riverpod/flutter_riverpod.dart' show ProviderScope;

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
        home: const ReusableScreen(),
      ),
    );
  }
}
