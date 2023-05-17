import 'dart:developer' show log;
import 'dart:io' show Directory, File;
import 'dart:isolate' show Isolate, ReceivePort, SendPort;
import 'dart:ui' show DartPluginRegistrant;

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart'
    show
        BackgroundIsolateBinaryMessenger,
        RootIsolateToken,
        ServicesBinding,
        Uint8List,
        rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show FamilyNotifier, NotifierProviderFamily, WidgetRef;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

final imgFileProvider =
    NotifierProviderFamily<_ImgFile, File?, String>(_ImgFile.new);

class _ImgFile extends FamilyNotifier<File?, String> {
 
  @override
  File? build(String arg) => null;

 

  void setFile(File? file) =>
    state = file;
 

  Future<File?> loadImg(WidgetRef ref, String path) async {
    try {
    
      // final file = await assetsToFile(path);
      final assetData = await rootBundle.load(path);
      final Uint8List byteList = assetData.buffer.asUint8List();
      const fileName = 'image.jpg'; // Set a desired file name

      final img.Image? image = img.decodeImage(byteList);
      img.billboard(image!,
          grid: 10, amount: 1, maskChannel: img.Channel.luminance);
      final Directory directory = await getApplicationDocumentsDirectory();
      final String filePath = '${directory.path}/$fileName';
      File imageFile = File(filePath);
      imageFile = await imageFile.writeAsBytes(img.encodeJpg(image));

      log(imageFile.path.toString());

      setFile(imageFile);
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

      setFile(file);
    });
    debugPrint('Isolate Started:');
  }
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
