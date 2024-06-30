import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  bool _isPharmacist = false;

  User? get currentUser => _currentUser;
  bool get isPharmacist => _isPharmacist;

  Future<void> registerWithEmail( String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    _currentUser = userCredential.user;

    await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).set({
      
      'email': email,
      'isPharmacist': _isPharmacist,
    });

    notifyListeners();
  }

  Future<void> signInWithEmail(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    _currentUser = userCredential.user;

    final doc = await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).get();
    _isPharmacist = doc.data()!['isPharmacist'];

    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _currentUser = null;
    _isPharmacist = false;
    notifyListeners();
  }
}
