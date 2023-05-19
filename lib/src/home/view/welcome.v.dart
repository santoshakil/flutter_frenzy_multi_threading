import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/extensions/context.dart';
import 'package:flutter_frenzy_multi_threading/src/home/view/home.v.dart';

class WelComeView extends StatelessWidget {
  const WelComeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: context.height * 0.3,
          child: const AnimatedFlutter(),
        ),
        const SizedBox(height: 32),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Welcome to',
            style: context.text.headlineSmall,
            children: [
              const TextSpan(text: '\n'),
              TextSpan(
                text: 'Flutter Frenzy',
                style: context.text.headlineLarge!.copyWith(
                  fontSize: context.height * 0.05,
                  color: context.colors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const TextSpan(text: '\n'),
              TextSpan(
                text: 'Multi Threading',
                style: context.text.headlineLarge!.copyWith(
                  fontSize: context.height * 0.04,
                  color: context.colors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.height * 0.1),
      ],
    );
  }
}
