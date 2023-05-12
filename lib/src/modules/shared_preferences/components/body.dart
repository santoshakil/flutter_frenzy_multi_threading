import 'package:flutter/material.dart';

import '../../../helper/size_config.dart';
import 'preview.dart';
import 'topics.dart';

class SharedPrefBody extends StatelessWidget {
  const SharedPrefBody({super.key});

  @override
  Widget build(BuildContext context) {
    print(ScreenSize.width);
    return const Row(
      children: [
        SharedPrefPreviewPanel(),
        TopicsPanel(),
      ],
    );
  }
}
