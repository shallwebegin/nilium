// ignore_for_file: lines_longer_than_80_chars

import 'package:nilium/product/utility/base/base_firebase_model.dart';
import 'package:nilium/product/utility/firebase/firebase_collections.dart';

mixin FirebaseUtility {
  Future<List<T>?> fetchList<T extends IdModel, R extends BaseFirebaseModel<T>>(
    R data,
    FirebaseCollections collections,
  ) async {
    final newsCollectionReference = collections.reference;
    final response = await newsCollectionReference.withConverter<T>(
      fromFirestore: (snapshot, options) {
        return data.fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return {};
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return null;
  }
}
