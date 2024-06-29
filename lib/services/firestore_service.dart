import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

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
    try {
      return await _db
          .collection('medicines')
          .where('name', isEqualTo: medicineName)
          .get();
    } catch (e) {
      print('Error searching medicine: $e');
      throw Exception('Failed to search medicine');
    }
  }

  
  Future<List<DocumentSnapshot>> getNearbyPharmaciesWithMedicine(String medicineName, LatLng userLocation) async {
    try {
      // 1. Get a reference to the pharmacies collection
      CollectionReference pharmaciesRef = _db.collection('pharmacies');

      // 2. Perform a query to find nearby pharmacies (adjust distance as per your requirements)
      QuerySnapshot querySnapshot = await pharmaciesRef
          .where('medicines.${medicineName.toLowerCase()}', isEqualTo: true) // Assuming medicines are stored as a map
          .where('location', isLessThanOrEqualTo: GeoPoint(userLocation.latitude + 0.1, userLocation.longitude + 0.1)) // Adjust distance range as needed
          .where('location', isGreaterThanOrEqualTo: GeoPoint(userLocation.latitude - 0.1, userLocation.longitude - 0.1))
          .get();

      // 3. Return the list of DocumentSnapshot objects for nearby pharmacies
      return querySnapshot.docs;
    } catch (e) {
      print('Error getting nearby pharmacies: $e');
      throw Exception('Failed to get nearby pharmacies');
    }
  
}

  Future<void> addMedicine(String userId, String name, String category, int quantity) async {
    await _db.collection('pharmacies').doc(userId).collection('medicines').add({
      'name': name,
      'category': category,
      'quantity': quantity,
    });
  }

  Future<void> updateMedicine(String userId, String medicineId, String name, String category, int quantity) async {
    await _db.collection('pharmacies').doc(userId).collection('medicines').doc(medicineId).update({
      'name': name,
      'category': category,
      'quantity': quantity,
      'userId': userId,
    });
  }

  Future<void> deleteMedicine(String userId, String medicineId) async {
    await _db.collection('pharmacies').doc(userId).collection('medicines').doc(medicineId).delete();
  }

  Future<void> addPharmacy(
      String userId, String pharmacyName, double latitude, double longitude) async {
    try {
      await _db.collection('pharmacies').add({
        'userId': userId,
        'pharmacyName': pharmacyName,
        'location': GeoPoint(latitude, longitude),
      });
    } catch (e) {
      print('Error adding pharmacy: $e');
      throw Exception('Failed to add pharmacy');
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
