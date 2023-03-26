import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homero/models/reccomendation_model.dart';

import '../models/ad_model.dart';
import '../models/service_model.dart';

class RecommendationDatabase {
  static CollectionReference<RecommendationModel> getRecommendationsCollection() {
    return FirebaseFirestore.instance
        .collection(RecommendationModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            RecommendationModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<List<RecommendationModel>> getRecommends() async {
    QuerySnapshot<RecommendationModel> querySnapshot =
    await getRecommendationsCollection().get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

}
