import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/code/provider/code.p.dart';

void withoutCompute(Ref ref) {
  ref.read(executionRunningProvider.notifier).state = true;
  final timer = Stopwatch()..start();
  _compute();
  timer.stop();
  ref.read(executionMessageProvider.notifier).state = 'Took: ${timer.elapsedMilliseconds}ms';
  ref.read(executionRunningProvider.notifier).state = false;
}

Future<void> withCompute(Ref ref) async {
  ref.read(executionRunningProvider.notifier).state = true;
  final timer = Stopwatch()..start();
  await compute(_compute, 0);
  timer.stop();
  ref.read(executionMessageProvider.notifier).state = 'Took: ${timer.elapsedMilliseconds}ms';
  ref.read(executionRunningProvider.notifier).state = false;
}

void _compute([int x = 0]) {
  for (var i = 0; i < 10000000000; i++) {
    x++;
  }
  debugPrint('Iteration: $x');
}
