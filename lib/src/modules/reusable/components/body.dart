import 'package:flutter/material.dart';

import 'options/options.dart';
import 'previews/preview.dart';

class ReusableBody extends StatelessWidget {
  const ReusableBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      PreviewPanel(),
      OptionsSelectPanel(),
    ]);
  }
}
