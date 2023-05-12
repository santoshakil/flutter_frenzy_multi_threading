import 'package:flutter/material.dart';
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
                  child: Text(
                    'Code Preview',
                    style: textTheme.labelLarge!.copyWith(
                      color: black87,
                    ),
                  ),
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
