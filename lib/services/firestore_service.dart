import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addPharmacy(String userId, String name, double lat, double lon) async {
    await _db.collection('pharmacies').doc(userId).set({
      'name': name,
      'location': GeoPoint(lat, lon),
    });
  }

  Future<void> addInventoryItem(String userId, String name, int quantity) async {
    await _db.collection('pharmacies').doc(userId).collection('inventory').add({
      'name': name,
      'quantity': quantity,
    });
  }

  Stream<QuerySnapshot> getInventoryStream(String userId) {
    return _db.collection('pharmacies').doc(userId).collection('inventory').snapshots();
  }
}
