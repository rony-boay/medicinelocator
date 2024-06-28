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
                bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
                if (!serviceEnabled) {
                  return Future.error('Location services are disabled.');
                }

                LocationPermission permission = await Geolocator.checkPermission();
                if (permission == LocationPermission.denied) {
                  permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.denied) {
                    return Future.error('Location permissions are denied.');
                  }
                }

                if (permission == LocationPermission.deniedForever) {
                  return Future.error('Location permissions are permanently denied, we cannot request permissions.');
                }

                _currentPosition = await Geolocator.getCurrentPosition();
                await firestoreService.addPharmacy(
                  widget.user.uid,
                  _pharmacyNameController.text,
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                );

                Navigator.pop(context);
              },
              child: Text('Add Pharmacy'),
            ),
          ],
        ),
      ),
    );
  }
}
