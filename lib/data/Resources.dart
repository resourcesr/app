import 'package:cloud_firestore/cloud_firestore.dart';

class Resources {
  Resources({this.courseId});

  // the code refers, to class_id
  final String courseId;
  final Firestore _firestore = Firestore.instance;

  // Get resources by course ID.
  Stream<QuerySnapshot> getByCourseId() {
    return _firestore
        .collection('subjects/courses/resources')
        .where("course_id", isEqualTo: this.courseId)
        .snapshots();
  }
}
