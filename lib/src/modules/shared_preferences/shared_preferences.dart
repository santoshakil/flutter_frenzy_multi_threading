import 'package:flutter/material.dart';
import '../../helper/themes/light.dart' show lightTheme;
import 'components/body.dart' show SharedPrefBody;

class SharedPreferencesScreen extends StatelessWidget {
  const SharedPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: lightTheme,
      child: const Scaffold(
        body: SharedPrefBody(),
      ),
    );
  }
}
