import 'package:cloud_firestore/cloud_firestore.dart';

class Klasss {
  Klasss({this.department});

  final String department;
  final Firestore _firestore = Firestore.instance;

  // Get class by departent code.
  Stream<QuerySnapshot> getByDepartment() {
    return _firestore
        .collection('subjects/classes/main')
        .where("program", isEqualTo: this.department)
        .snapshots();
  }
}
