import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../services/firestore_service.dart';

class AddPharmacyScreen extends StatefulWidget {
  final User user;

  AddPharmacyScreen({required this.user});

  @override
  _AddPharmacyScreenState createState() => _AddPharmacyScreenState();
}

class _AddPharmacyScreenState extends State<AddPharmacyScreen> {
  final _pharmacyNameController = TextEditingController();
  late Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pharmacy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pharmacyNameController,
              decoration: InputDecoration(labelText: 'Pharmacy Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
                  if (!serviceEnabled) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Location services are disabled.'))
                    );
                    return;
                  }

                  LocationPermission permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied) {
                    permission = await Geolocator.requestPermission();
                    if (permission == LocationPermission.denied) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Location permissions are denied.'))
                      );
                      return;
                    }
                  }

                  if (permission == LocationPermission.deniedForever) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Location permissions are permanently denied.'))
                    );
                    return;
                  }

                  _currentPosition = await Geolocator.getCurrentPosition();

                  await firestoreService.addPharmacy(
                    widget.user.uid,
                    _pharmacyNameController.text,
                    _currentPosition.latitude,
                    _currentPosition.longitude,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pharmacy added successfully!'),
                      duration: Duration(seconds: 1), // Duration of the success message
                    ),
                  );

                  // Wait for the duration of the SnackBar and then navigate back to the main pharmacist home page
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.popUntil(context, ModalRoute.withName('/pharmacist_home'));
                  });

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add pharmacy: $e'))
                  );
                }
              },
              child: Text('Add Pharmacy'),
            ),
          ],
        ),
      ),
    );
  }
}
