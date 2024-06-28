import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<bool> get isPharmacist async {
    if (currentUser == null) return false;

    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser!.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        return data?['role'] == 'pharmacist';
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> registerWithEmail(String email, String password, String role) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'role': role,
        });
      }
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser() async {
    try {
      await currentUser?.delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      await currentUser?.updateEmail(newEmail);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  bool get isEmailVerified {
    return currentUser?.emailVerified ?? false;
  }
}
