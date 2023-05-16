import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_frenzy_multi_threading/src/helper/size_config.dart';
import 'package:flutter_frenzy_multi_threading/src/modules/components/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

DateTime? start;
DateTime? end;

class LargeImageScreen extends StatefulWidget {
  const LargeImageScreen({super.key});

  @override
  State<LargeImageScreen> createState() => _LargeImageScreenState();
}

class _LargeImageScreenState extends State<LargeImageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  File? f;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (f == null) const CircularProgressIndicator(),
          Consumer(builder: (context, state, __) {
            final fileP = state.watch(fileProvider);
            if (fileP == null) return const SizedBox();
            return SizedBox(
                width: ScreenSize.width,
                height: ScreenSize.height * .4,
                child: Image.file(fileP));
          }),
          Consumer(builder: (context, state, __) {
            return SizedBox(
                child: ElevatedButton(
              onPressed: () async {
                const assetsPath = 'assets/images/IMG_20230514_215912.jpg';
                start = DateTime.now();
                // f = await loadImg(assetsPath);
                // log(start!.toLocal().toString());
                // log(DateTime.now().difference(start!).toString());
                await startThread(state, assetsPath);
              },
              child: Text('------------------'),
            )
                // child: FutureBuilder<Uint8List>(
                //   future: loadImg('assets/images/IMG_20230514_215912.jpg'),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       final imageBytes = snapshot.data!;
                //       return Image.memory(imageBytes);
                //     } else if (snapshot.hasError) {
                //       return Text('Error occurred while loading the image.');
                //     }
                //     return const CircularProgressIndicator();
                //   },
                // ),
                );
          }),
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

// Future<Uint8List> loadImg(String path) async {
//   final receivePort = ReceivePort();
//   final isolate = await Isolate.spawn(
//     _doSomethingInIsolate,
//     [receivePort.sendPort, ServicesBinding.rootIsolateToken, path],
//     onExit: receivePort.sendPort,
//     onError: receivePort.sendPort,
//   );
//   isolate.addOnExitListener(receivePort.sendPort, response: 'Isolate exited');
//   receivePort.listen((message) => debugPrint(message.toString()));
//   log(receivePort.first.toString());
//   return receivePort.first as Uint8List;
// }

// Future<void> _doSomethingInIsolate(List m) async {
//   DartPluginRegistrant.ensureInitialized();
//   BackgroundIsolateBinaryMessenger.ensureInitialized(m[1] as RootIsolateToken);

//   try {
//     final assets = m[2] as String;
//     log(assets);
//     final data = await rootBundle.load('assets/images/IMG_20230514_215912.jpg');
//     log(data.toString());
//     final bytes = data.buffer.asUint8List();
//     log(bytes.toString());
//     final sendPort = m[0] as SendPort;
//     sendPort.send(bytes);
//   } catch (e) {
//     log(e.toString());
//   }
// }

Future<File?> loadImg(String path) async {
  try {
    final file = await assetsToFile(path);
    final assetData = await rootBundle.load(path);
    final Uint8List byteList = assetData.buffer.asUint8List();
    const fileName = 'image.jpg'; // Set a desired file name

    final img.Image? image = img.decodeImage(byteList);
//  { num grid = 10, num amount = 1, Image? mask, Channel maskChannel = Channel.luminance }
    img.billboard(image!,
        grid: 10, amount: 1, maskChannel: img.Channel.luminance);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    File imageFile = File(filePath);
    imageFile = await imageFile.writeAsBytes(img.encodeJpg(image));

    log(imageFile.path.toString());
    /*
    // Image image = Image.file(file);
    // final offset = img.colorOffset(image);
    final image = img.readFile(file.path);
    final offset = img.colorOffset(image);
    final png = img.encodePng(offset);
    final Directory directory = await getApplicationDocumentsDirectory();

    final f = await File('${directory.path}/image.png').writeAsBytes(png);
    log(f.path);
    return f;
    */

    return imageFile;
  } catch (e) {
    log(e.toString());
  }
  return null;
}

Future<File> assetsToFile(String assetPath) async {
  final assetData = await rootBundle.load(assetPath);

  final byteList = assetData.buffer.asUint8List();
  const fileName = 'image.jpg'; // Set a desired file name

  // Get the document directory using path_provider package
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';

  final File imageFile = File(filePath);
  await imageFile.writeAsBytes(byteList);

  return imageFile;
}

Future<void> startThread(WidgetRef ref, String path) async {
  final receivePort = ReceivePort();
  final file = await assetsToFile(path);
  final isolate = await Isolate.spawn(
    _doSomethingInIsolate,
    [receivePort.sendPort, ServicesBinding.rootIsolateToken, file],
    onExit: receivePort.sendPort,
    onError: receivePort.sendPort,
  );
  isolate.addOnExitListener(receivePort.sendPort, response: 'Isolate exited');
  receivePort.listen((message) {
    final file = message as File;
    log(file.path);

    ref.read(fileProvider.notifier).update(file.path);
  });
  debugPrint('Isolate Started:');
}

Future<void> _doSomethingInIsolate(List m) async {
  DartPluginRegistrant.ensureInitialized();
  BackgroundIsolateBinaryMessenger.ensureInitialized(m[1] as RootIsolateToken);

  final file = m.last as File;
///////////////////////////
  try {
    final fileBytes = await file.readAsBytes();
    final uint8List = Uint8List.fromList(fileBytes);
    const fileName = 'image.jpg'; // Set a desired file name

    final img.Image? image = img.decodeImage(uint8List);
//  { num grid = 10, num amount = 1, Image? mask, Channel maskChannel = Channel.luminance }
    img.billboard(image!,
        grid: 10, amount: 1, maskChannel: img.Channel.luminance);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    File imageFile = File(filePath);
    imageFile = await imageFile.writeAsBytes(img.encodeJpg(image));

    /////////////////////
    final sendPort = m[0] as SendPort;
    sendPort.send(imageFile);
  } catch (e) {
    log('!!!ERROR : $e');
  }
}

final fileProvider = NotifierProvider<_File, File?>(_File.new);

class _File extends Notifier<File?> {
  @override
  File? build() => null;
  void update(String path) {
    print(path);
    state = File(path);
  }
}
