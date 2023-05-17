import 'package:flutter/material.dart';

import 'components/images.dart' show AsyncImage, ThreadImage;

class LargeImageScreen extends StatelessWidget {
  const LargeImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: Row(children: [AsyncImage(), ThreadImage()])),
        Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
      ],
    ));
  }
}
