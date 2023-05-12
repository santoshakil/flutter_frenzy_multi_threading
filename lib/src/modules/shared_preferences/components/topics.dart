import 'package:flutter/material.dart';
import '/src/helper/constants/colors/colors.dart' show white;
import '/src/helper/size_config.dart' show ScreenSize;

class TopicsPanel extends StatelessWidget {
  const TopicsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.width * .2,
      // height: ScreenSize.height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 40, 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: ColoredBox(
            color: white.withOpacity(.05),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Examples',
                    style: Theme.of(context).textTheme.labelLarge,
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
