import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionSubmissionScreen extends StatefulWidget {
  @override
  _PrescriptionSubmissionScreenState createState() => _PrescriptionSubmissionScreenState();
}

class _PrescriptionSubmissionScreenState extends State<PrescriptionSubmissionScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final pickedFile = await _picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _image = File(pickedFile.path);
                  });
                }
              },
              child: Text('Take a Picture'),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit the prescription
              },
              child: Text('Submit Prescription'),
            ),
          ],
        ),
      ),
    );
  }
}
