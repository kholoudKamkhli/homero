import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ad_model.dart';
import '../models/service_model.dart';

class AdDatabase {
  static CollectionReference<AdModel> getAdsCollection() {
    return FirebaseFirestore.instance
        .collection(AdModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            AdModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<List<AdModel>> getAds() async {
    QuerySnapshot<AdModel> querySnapshot =
    await getAdsCollection().get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

}
