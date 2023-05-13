import 'package:flutter/material.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(flex: 4, child: Text('Preview'));
  }
}
