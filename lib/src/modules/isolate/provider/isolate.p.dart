import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void withoutIsolate() async {
  final image = await rootBundle.load('assets/images/IMG_20230514_215912.jpg');

  Uint8List imageData = image.buffer.asUint8List();

  convertToBlackAndWhite(imageData);

  debugPrint('Image conversion complete.');
}

Uint8List convertToBlackAndWhite(Uint8List imageData) {
  Uint8List blackAndWhiteImageData = Uint8List.fromList(imageData);

  for (int i = 0; i < blackAndWhiteImageData.length; i += 3) {
    int red = blackAndWhiteImageData[i];
    int green = blackAndWhiteImageData[i + 1];
    int blue = blackAndWhiteImageData[i + 2];

    // Calculate the luminance value for each pixel
    int luminance = ((red * 0.299) + (green * 0.587) + (blue * 0.114)).toInt();

    // Set the red, green, and blue components of the pixel to the luminance value
    blackAndWhiteImageData[i] = luminance;
    blackAndWhiteImageData[i + 1] = luminance;
    blackAndWhiteImageData[i + 2] = luminance;
  }

  return blackAndWhiteImageData;
}

void withIsolate() async {}
