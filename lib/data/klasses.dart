import 'package:cloud_firestore/cloud_firestore.dart';

class Klasss {
  Klasss({this.department});

  final String department;
  final Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> getByDepartment() {
    return _firestore
        .collection('subjects/classes/main')
        .where("class_id", isEqualTo: this.department)
        .snapshots();
  }
}
