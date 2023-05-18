import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/extensions/context.dart';
import 'package:flutter_frenzy_multi_threading/src/home/view/home.v.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/action.side.bar.v.dart';
import '../../components/code.v.dart';

class ComputeView extends ConsumerWidget {
  const ComputeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        Expanded(
          child: Card(
            child: CodePreview(code: 'shared_pref_final.png'),
          ),
        ),
        ActionSideBar(),
      ],
    );
  }
}
