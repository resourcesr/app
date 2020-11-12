import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AccountStatus { Success, LoggedOut, Error }

class User with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String _uid, _name, _role, _klass, _sap;
  AccountStatus status = AccountStatus.LoggedOut;
  String get uid => _uid;
  String get name => _name;
  String get role => _role;
  String get klass => _klass;
  String get sap => _sap;

  // Init the user class.
  User(_uid) {
    if (_uid != "") {
      refresh();
      status = AccountStatus.Success;
      notifyListeners();
    }
  }

  refresh() async {
    getCurrentUser().then((value) => {
          getUserProfile(value.uid).then((val) {
            if (val != null) {
              _name = val['name'];
              _role = val['role'];
              _klass = val['klass'];
              _sap = val['sap'];

              //notifyListeners();
            } else {
              // If user profile deleted or disable force him to logout.
              logout();
            }
          })
        });
  }

  // Store user Id in local preferene
  Future<void> saveId(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uid", uid);
  }

  // Get user profile.
  Future<dynamic> getUserProfile(String id) async {
    var doc = await _firestore.document("/users/$id/").get();
    return doc.data;
  }

  // Get user profile.
  Future<dynamic> hasProfile(String id) async {
    var doc = await _firestore.document("/users/$id/").get();
    return doc.exists;
  }

  // Save user profile
  Future<void> saveUserInDocument(String uid, String name, String sap) async {
    await _firestore.collection("users").document(uid).setData({
      "name": name,
      "sap": sap,
      'role': "student",
      'klass': null,
    });
  }

  // Update user profile
  Future<void> updateProfile(String uid, String name, String sap) async {
    await _firestore.collection("users").document(uid).updateData({
      "name": name,
      "sap": sap,
    });
  }

  // Update user profile
  Future<void> update(String name, String sap) async {
    var value = await getCurrentUser();
    String uid = value.uid;
    bool profile = await hasProfile(uid);
    if (profile)
      await updateProfile(uid, name, sap);
    else
      await saveUserInDocument(uid, name, sap);
  }

  // Update user class.
  Future<void> updateKlass(String k_id) async {
    getCurrentUser().then((val) => {
          _firestore.collection("users").document(val.uid).updateData({
            "klass": k_id,
          })
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
      status = AccountStatus.Success;
      notifyListeners();
      return User(user.uid);
    }
  }

  Future<User> loginWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    if (user != null) {
      saveId(user.uid);
      status = AccountStatus.Success;
      notifyListeners();
      return User(user.uid);
    }
  }

  /// User logout
  Future<void> logout() async {
    _firebaseAuth.signOut();
    saveId(null);
    status = AccountStatus.LoggedOut;
    notifyListeners();
  }

  /// reset user password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
