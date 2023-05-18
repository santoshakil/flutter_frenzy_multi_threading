import 'package:flutter/foundation.dart';

void withoutCompute() => _compute();

Future<void> withCompute() async => await compute(_compute, 0);

void _compute([int x = 0]) {
  for (var i = 0; i < 10000000000; i++) {
    i++;
  }
  debugPrint('Iteration: $x');
}
