import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/home/model/home.m.dart';

import '../../extensions/context.dart';
import '../../home/view/home.v.dart';

class ActionSideBar extends StatelessWidget {
  const ActionSideBar({super.key, this.child, required this.module});

  final Widget? child;
  final Modules module;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.2,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.2,
              child: const AnimatedFlutter(),
            ),
            if (child != null) Expanded(child: child!)
          ],
        ),
      ),
    );
  }
}
