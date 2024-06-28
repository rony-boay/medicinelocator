import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/mlkit_service.dart';

class MedicineSearchScreen extends StatefulWidget {
  @override
  _MedicineSearchScreenState createState() => _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String _recognizedText = '';

  @override
  Widget build(BuildContext context) {
    final mlKitService = MLKitService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Medicine by Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  _image = File(pickedFile.path);
                  _recognizedText = (await mlKitService.recognizeText(_image!))!;
                  setState(() {});
                }
              },
              child: Text('Pick an Image'),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            SizedBox(height: 20),
            Text('Recognized Text:'),
            Text(_recognizedText),
          ],
        ),
      ),
    );
  }
}
