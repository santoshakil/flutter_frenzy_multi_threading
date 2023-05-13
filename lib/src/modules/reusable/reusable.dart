import 'package:flutter/material.dart';
import '/src/helper/themes/dark.dart' show darkTheme;

import 'components/body.dart' show ReusableBody;

class ReusableScreen extends StatelessWidget {
  const ReusableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme,
      child: const Scaffold(
        body: ReusableBody(),
      ),
    );
  }
}
