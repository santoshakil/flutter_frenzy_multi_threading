import 'package:flutter/material.dart';

import '../../modules/compute/view/compute.v.dart';
import '../../modules/ffi/view/ffi.v.dart';
import '../../modules/isolate/view/isolate.v.dart';
import '../../modules/persistant/view/persistant.v.dart';
import '../../modules/synchronization/view/synchronization.v.dart';

enum Modules {
  compute(
    'compute',
    'Allows you to run Dart code in a separate thread, which can be useful for short-running heavy tasks that require a lot of CPU power.',
    ComputeView(key: Key('computeView')),
  ),
  isolate(
    'Isolate',
    'Allows you to create a separate thread, which can be useful for running long-running heavy tasks concurrently or isolating tasks that might interfere with each other.',
    IsolateView(key: Key('isolateView')),
  ),
  persistent(
    'Persistent Thread',
    'Allows you to persist threads, which can be useful for running long-running heavy tasks without having to recreate them every time.',
    PersistantView(key: Key('persistantView')),
  ),
  synchronization(
    'Synchronization',
    'Allows you to synchronize access to shared data, which can be useful for preventing race conditions.',
    SynchronizationView(key: Key('synchronizationView')),
  ),
  ffi(
    'FFI',
    'Allows you to call foreign code from Dart, which can be useful for using native libraries or system calls that are not available in Dart and creating necessary threads for them.',
    FFIView(key: Key('ffiView')),
  );

  const Modules(this.title, this.description, this.view);

  final String title;
  final String description;
  final Widget view;
}
