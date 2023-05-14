import 'package:flutter/material.dart';

class PersistantView extends StatelessWidget {
  const PersistantView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(key.toString()),
    );
  }
}
