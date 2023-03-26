import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homero/database/service_database.dart';

import '../models/service_model.dart';


class SubServiceDatabase {
  static CollectionReference<SubServiceModel> getSubServicesCollection() {
    return FirebaseFirestore.instance
        .collection(ServiceModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            SubServiceModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }



}
