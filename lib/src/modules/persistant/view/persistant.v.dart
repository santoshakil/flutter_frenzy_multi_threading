import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/model/home.m.dart';
import '../../components/action.side.bar.v.dart';
import '../../components/code/view/code.v.dart';

class PersistantView extends ConsumerWidget {
  const PersistantView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        CodePreview(module: Modules.persistent),
        ActionSideBar(),
      ],
    );
  }
}
