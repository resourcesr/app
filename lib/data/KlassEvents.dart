import 'package:cloud_firestore/cloud_firestore.dart';

class KlassEvents {
  KlassEvents({this.klassId});

  final String klassId;
  final Firestore _firestore = Firestore.instance;

  // Get event by course ID.
  Stream<QuerySnapshot> getByKlassId() {
    return _firestore
        .collection('subjects/classes/event')
        .where("klass_id", isEqualTo: this.klassId)
        .snapshots();
  }
}
