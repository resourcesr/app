import 'package:cloud_firestore/cloud_firestore.dart';

class Resources {
  Resources({required this.courseId});

  // the code refers, to class_id
  final String courseId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get resources by course ID.
  Stream<QuerySnapshot> getByCourseId() {
    return _firestore
        .collection('subjects/courses/resources')
        .where("course_id", isEqualTo: this.courseId)
        .orderBy('created', descending: true)
        .snapshots();
  }
}
