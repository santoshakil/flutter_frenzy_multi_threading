import 'package:flutter/foundation.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/components/code/provider/code.p.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synchronized/synchronized.dart';

final _lock = Lock();

void withoutSynchronization(Ref ref) async {
  ref.read(executionMessageProvider.notifier).state = 'Executing without synchronization: ${DateTime.now()}';
  await compute(_task, null);
  ref.read(executionMessageProvider.notifier).state = 'Executed without synchronization: ${DateTime.now()}';
  await Future.delayed(const Duration(seconds: 1));
}

void wihtSynchronization(Ref ref) async {
  await _lock.synchronized(() async {
    ref.read(executionMessageProvider.notifier).state = 'Executing with synchronization: ${DateTime.now()}';
    await compute(_task, null);
    ref.read(executionMessageProvider.notifier).state = 'Executed with synchronization: ${DateTime.now()}';
    await Future.delayed(const Duration(seconds: 1));
  });
}

Future<void> _task(_) async => await Future.delayed(const Duration(seconds: 2));
