import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

class FirestoreService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Medicine>> getMedicines(String userId) {
    return _db
        .collection('pharmacies')
        .doc(userId)
        .collection('medicines')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Medicine.fromFirestore(doc)).toList());
  }

  Future<QuerySnapshot> searchMedicine(String medicineName) async {
    return await _retry(() => _db
        .collection('medicines')
        .where('name', isEqualTo: medicineName)
        .get());
  }

  Future<List<DocumentSnapshot>> getNearbyPharmaciesWithMedicine(
      String medicineName, LatLng userLocation) async {
    return await _retry(() async {
      CollectionReference pharmaciesRef = _db.collection('pharmacies');
      QuerySnapshot querySnapshot = await pharmaciesRef
          .where('medicines.${medicineName.toLowerCase()}', isEqualTo: true)
          .where('location',
              isLessThanOrEqualTo: GeoPoint(
                  userLocation.latitude + 0.1, userLocation.longitude + 0.1))
          .where('location',
              isGreaterThanOrEqualTo: GeoPoint(
                  userLocation.latitude - 0.1, userLocation.longitude - 0.1))
          .get();
      return querySnapshot.docs;
    });
  }

  Future<void> addMedicine(
      String userId, String name, String category, int quantity) async {
    await _retry(() =>
        _db.collection('pharmacies').doc(userId).collection('medicines').add({
          'name': name,
          'category': category,
          'quantity': quantity,
        }));
  }

  Future<void> updateMedicine(String userId, String medicineId, String name,
      String category, int quantity) async {
    await _retry(() => _db
            .collection('pharmacies')
            .doc(userId)
            .collection('medicines')
            .doc(medicineId)
            .update({
          'name': name,
          'category': category,
          'quantity': quantity,
          'userId': userId,
        }));
  }

  Future<void> deleteMedicine(String userId, String medicineId) async {
    await _retry(() => _db
        .collection('pharmacies')
        .doc(userId)
        .collection('medicines')
        .doc(medicineId)
        .delete());
  }

  Future<void> addPharmacy(String userId, String pharmacyName, double latitude,
      double longitude) async {
    await _retry(() => _db.collection('pharmacies').add({
          'userId': userId,
          'pharmacyName': pharmacyName,
          'location': GeoPoint(latitude, longitude),
        }));
  }

  Future<T> _retry<T>(Future<T> Function() operation,
      {int retries = 3, Duration delay = const Duration(seconds: 2)}) async {
    int attempt = 0;
    while (true) {
      attempt++;
      try {
        return await operation();
      } catch (e) {
        if (attempt > retries || e is! FirebaseException) {
          rethrow;
        }
        await Future.delayed(delay);
      }
    }
  }
}

class Medicine {
  final String id;
  final String name;
  final String category;
  final int quantity;

  Medicine(
      {required this.id,
      required this.name,
      required this.category,
      required this.quantity});

  factory Medicine.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Medicine(
      id: doc.id,
      name: data['name'],
      category: data['category'],
      quantity: data['quantity'],
    );
  }
}
