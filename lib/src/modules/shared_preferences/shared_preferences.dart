import 'package:flutter/material.dart';
import '../../helper/themes/dark.dart';
import 'components/body.dart' show SharedPrefBody;

class SharedPreferencesScreen extends StatelessWidget {
  const SharedPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      // data: lightTheme,
      data: darkTheme,
      child: const Scaffold(
        body: SharedPrefBody(),
      ),
    );
  }
}
