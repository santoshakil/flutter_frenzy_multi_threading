import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/home/model/home.m.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/action.side.bar.v.dart';
import '../../components/code/view/code.v.dart';

class ComputeView extends ConsumerWidget {
  const ComputeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        CodePreview(module: Modules.compute),
        ActionSideBar(),
      ],
    );
  }
}
