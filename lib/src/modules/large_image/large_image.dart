import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frenzy_multi_threading/src/helper/size_config.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/components/button.dart';

class LargeImageScreen extends StatelessWidget {
  const LargeImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: ScreenSize.width,
            height: ScreenSize.height * .4,
            child: FutureBuilder<Uint8List>(
              future: loadImg('assets/images/IMG_20230514_215912.jpg'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final imageBytes = snapshot.data!;
                  return Image.memory(imageBytes);
                } else if (snapshot.hasError) {
                  return Text('Error occurred while loading the image.');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(
            width: ScreenSize.width,
            height: ScreenSize.height * .4,
            child: Image.asset('assets/images/IMG_20230514_215912.jpg'),
          ),
        ],
      ),
    );
  }
}

Future<Uint8List> loadImg(String path) async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    _doSomethingInIsolate,
    [receivePort.sendPort, ServicesBinding.rootIsolateToken, path],
    onExit: receivePort.sendPort,
    onError: receivePort.sendPort,
  );
  isolate.addOnExitListener(receivePort.sendPort, response: 'Isolate exited');
  receivePort.listen((message) => debugPrint(message.toString()));
  log(receivePort.first.toString());
  return receivePort.first as Uint8List;
}

Future<void> _doSomethingInIsolate(List m) async {
  DartPluginRegistrant.ensureInitialized();
  BackgroundIsolateBinaryMessenger.ensureInitialized(m[1] as RootIsolateToken);

  try {
    final assets = m[2] as String;
    log(assets);
    final data = await rootBundle.load('assets/images/IMG_20230514_215912.jpg');
    log(data.toString());
    final bytes = data.buffer.asUint8List();
    log(bytes.toString());
    final sendPort = m[0] as SendPort;
    sendPort.send(bytes);
  } catch (e) {
    log(e.toString());
  }
}
