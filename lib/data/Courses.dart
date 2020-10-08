import 'package:cloud_firestore/cloud_firestore.dart';

class Courses {
  Courses({this.code});

  // the code refers, to class_id
  final String code;
  final Firestore _firestore = Firestore.instance;

  // Get course by class ID.
  Stream<QuerySnapshot> getByClassId() {
    return _firestore
        .collection('subjects/classes/courses')
        .where("class_id", isEqualTo: this.code)
        .snapshots();
  }
}
