import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  String _uid, _name, _role, _subject;
  String get uid => _uid;
  String get name => _name;
  String get role => _role;
  String get subject => _subject;

  User() {
    getPrefState().then((val) {
      if (val != null) {
        _uid = val;
        _loggedIn = true;
      }
      notifyListeners();
      getUserProfile(_uid).then((val) {
        if (val != null) {
          _name = val['name'] ?? "";
          _role = val['role'];
          _subject = val['subject'] ?? null;
        }
        notifyListeners();
      });
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

  Future<dynamic> getUserProfile(String id) async {
    var doc = await _firestore.document("/users/$id/").get();
    //return doc.documentID;
    return doc.data;
  }

  Future<void> update(String uid, String name, String sap) {
    _firestore.collection("users").document(uid).updateData({
      "name": name,
      "sap": sap,
    });
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
