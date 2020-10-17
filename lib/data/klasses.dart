import 'package:cloud_firestore/cloud_firestore.dart';

class Klasss {
  Klasss({this.department});

  final String department;
  final Firestore _firestore = Firestore.instance;

  // Get all classes.
  Stream<QuerySnapshot> getAllKlasses() {
    return _firestore.collection('subjects/classes/main').snapshots();
  }

  // Get class by departent code.
  Stream<QuerySnapshot> getByDepartment() {
    return _firestore
        .collection('subjects/classes/main')
        .where("program", isEqualTo: this.department)
        .orderBy('created', descending: true)
        .snapshots();
  }
}
