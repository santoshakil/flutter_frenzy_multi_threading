import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/action.side.bar.v.dart';
import '../../components/code.v.dart';

class SynchronizationView extends ConsumerWidget {
  const SynchronizationView({super.key});

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
