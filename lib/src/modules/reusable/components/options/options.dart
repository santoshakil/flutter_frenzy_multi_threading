import 'package:flutter/material.dart';
import '/src/helper/constants/colors/colors.dart' show white;
import '/src/modules/reusable/components/nevigation.dart'
    show NavigationButtons;
import '/src/modules/reusable/components/next_button.dart' show NextButton;
import '/src/modules/reusable/components/run_code.dart' show RunCodeButton;

import 'option_list.dart' show OptionsList;

class OptionsSelectPanel extends StatelessWidget {
  const OptionsSelectPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
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
                const OptionsList(),
                const NextButton(),
                const RunCodeButton(),
                const NavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
