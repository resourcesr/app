import 'package:cloud_firestore/cloud_firestore.dart';

class Courses {
  Courses({required this.code});

  // the code refers, to class_id
  final String code;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get course by class ID.
  Stream<QuerySnapshot> getByClassId() {
    return _firestore
        .collection('subjects/classes/courses')
        .where("class_id", isEqualTo: this.code)
        .orderBy('created', descending: true)
        .snapshots();
  }
}
