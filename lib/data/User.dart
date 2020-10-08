import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AccountStatus { Success, LoggedOut }

class User with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  String _uid, _name, _role, _subject;
  AccountStatus status = AccountStatus.LoggedOut;
  String get uid => _uid;
  String get name => _name;
  String get role => _role;
  String get subject => _subject;

  // Init the user class.
  User(_uid) {
    if (_uid != "") {
      _loggedIn = true;
      getUserProfile(_uid).then((val) {
        if (val != null) {
          _name = val['name'];
          _role = val['role'];
          _subject = val['subject'] ?? null;
        }
        notifyListeners();
      });
      status = AccountStatus.Success;
      notifyListeners();
    }
  }

  // get user preference.
  Future<String> getPrefState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('uid');
    return stringValue;
  }

  // Store user Id in local preferene
  Future<void> saveId(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", uid);
  }

  // Get user profile.
  Future<dynamic> getUserProfile(String id) async {
    var doc = await _firestore.document("/users/$id/").get();
    //return doc.documentID;
    return doc.data;
  }

  // Update user profile
  Future<void> update(String uid, String name, String sap) {
    _firestore.collection("users").document(uid).updateData({
      "name": name,
      "sap": sap,
    });
  }

  // Save user profile
  Future<void> saveUserInDocument(String uid, String name, String sap) {
    _firestore.collection("users").document(uid).setData({
      "name": name,
      "sap": sap,
      'role': "student",
    });
  }

  // Get current user.
  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  // user signup.
  Future<User> signup(
      String email, String password, String name, String sap) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      saveUserInDocument(user.uid, name, sap);
      saveId(user.uid);
      _loggedIn = true;
      status = AccountStatus.Success;
      notifyListeners();
      return User(user.uid);
    }
  }

  /// user login
  Future<User> login(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      saveId(user.uid);
      _loggedIn = true;
      status = AccountStatus.Success;
      notifyListeners();
      return User(user.uid);
    }
  }

  /// User logout
  Future<void> logout() async {
    _firebaseAuth.signOut();
    saveId(null);
    _loggedIn = false;
    status = AccountStatus.LoggedOut;
    notifyListeners();
  }

  /// reset user password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
