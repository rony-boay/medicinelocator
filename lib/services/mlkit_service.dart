import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';

class MLKitService {
  Future<String?> recognizeText(File imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    return recognizedText.text;
  }
}
