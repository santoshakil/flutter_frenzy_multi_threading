import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/extensions/context.dart';
import 'package:flutter_frenzy_multi_threading/src/extensions/string.dart';
import 'package:flutter_frenzy_multi_threading/src/home/model/home.m.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/code.p.dart';

class CodePreview extends ConsumerWidget {
  const CodePreview({super.key, required this.module});

  final Modules module;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keys = module.codes.keys;
    return Expanded(
      child: Card(
        child: PageView.builder(
          controller: ref.watch(codePageControllerProvider(module)),
          itemCount: keys.length,
          itemBuilder: (context, index) {
            final code = keys.elementAt(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (code.isNotEmpty)
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      code,
                      style: context.text.titleLarge!.copyWith(
                        color: code.withWithoutColor,
                      ),
                    ),
                  ),
                Expanded(
                  child: Image.asset(
                    'assets/images/${(code.isNotEmpty ? code : module.title).snackCase}.png',
                    key: ValueKey('CodePreview$code'),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
