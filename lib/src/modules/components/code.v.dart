import 'package:flutter/material.dart';

class CodePreview extends StatelessWidget {
  const CodePreview({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$code',
      key: ValueKey('CodePreview$code'),
      fit: BoxFit.cover,
    );
  }
}
