import 'package:flutter/material.dart';
import 'preview.dart';
import 'topics.dart';

class SharedPrefBody extends StatelessWidget {
  const SharedPrefBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SharedPrefPreviewPanel(),
        TopicsPanel(),
      ],
    );
  }
}
