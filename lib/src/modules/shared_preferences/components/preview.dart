import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/shared_preferences/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/src/helper/constants/colors/colors.dart' show black87, white;

class SharedPrefPreviewPanel extends StatelessWidget {
  const SharedPrefPreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColoredBox(
            color: white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Consumer(builder: (context, ref, __) {
                    final selectedType =
                        ref.watch(selectedSharedPrefTypeProvider);
                    return Text(
                      selectedType.title ?? '',
                      style: textTheme.labelLarge!.copyWith(
                        color: black87,
                      ),
                    );
                  }),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Preview',
                      style: textTheme.labelMedium!.copyWith(
                        color: black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
