import 'package:flutter/material.dart';

class IsolateView extends StatelessWidget {
  const IsolateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(key.toString()),
    );
  }
}
