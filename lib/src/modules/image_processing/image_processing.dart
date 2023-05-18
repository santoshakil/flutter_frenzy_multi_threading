import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/helper/constants/colors/colors.dart';

import 'components/images.dart' show AsyncImage, ThreadImage;

class LargeImageScreen extends StatelessWidget {
  const LargeImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Row(children: [
          const AsyncImage(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: .5,
              child: ColoredBox(color: white),
            ),
          ),
          const ThreadImage()
        ])),
        const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
