import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  String _uid = "";
  String get uid => _uid;
  User() {
    getPrefState().then((val) {
      if (val != null) {
        _uid = val;
        _loggedIn = true;
      }
      notifyListeners();
    });
  }

  Future<String> getPrefState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('uid');
    return stringValue;
  }

  Future<void> saveId(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", uid);
  }

  Future<void> saveUserInDocument(String uid, String name, String sap) {
    _firestore.collection("users").document(uid).setData({
      "name": name,
      "sap": sap,
      'role': "student",
    });
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  // user signup.
  Future<void> signup(
      String email, String password, String name, String sap) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      saveUserInDocument(user.uid, name, sap);
      saveId(user.uid);
      _loggedIn = true;
      notifyListeners();
    }
  }

  /// user login
  Future<void> login(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      saveId(user.uid);
      _loggedIn = true;
      notifyListeners();
    }
  }

  /// User logout
  Future<void> logout() async {
    _firebaseAuth.signOut();
    saveId(null);
    _loggedIn = false;
    notifyListeners();
  }

  /// reset user password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
