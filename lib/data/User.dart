import 'package:firebase_auth/firebase_auth.dart';

class User {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// User login
  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /// reset user password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
