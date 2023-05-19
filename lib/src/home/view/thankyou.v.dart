import 'package:flutter/material.dart';
import 'package:flutter_frenzy_multi_threading/src/extensions/context.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home.v.dart';

class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        SizedBox(
          height: context.height * 0.3,
          child: const AnimatedFlutter(),
        ),
        const SizedBox(height: 32),
        Text(
          'Thank You!',
          textAlign: TextAlign.center,
          style: context.text.headlineLarge!.copyWith(
            fontSize: context.height * 0.05,
            color: context.colors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: _launchUrl,
            child: Text(
              _url.toString(),
              style: context.text.labelSmall!.copyWith(
                color: context.colors.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final _url = Uri.parse('https://github.com/santoshakil/flutter_frenzy_multi_threading');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
