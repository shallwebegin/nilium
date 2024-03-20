import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  version,
  news,
  tag,
  recommanded,
  category;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);
}
