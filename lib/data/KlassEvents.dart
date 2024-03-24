import 'package:cloud_firestore/cloud_firestore.dart';

class KlassEvents {
  KlassEvents({required this.klassId, required this.sem});

  final String klassId;
  final int sem;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get event by course ID.
  Stream<QuerySnapshot> getByKlassId() {
    return _firestore
        .collection('events')
        .where("klass_id", isEqualTo: this.klassId)
        .where("sem", isEqualTo: this.sem)
        .snapshots();
  }
}
