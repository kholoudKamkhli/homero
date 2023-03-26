import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/service_model.dart';

class ServiceDatabase {
  static CollectionReference<ServiceModel> getServicesCollection() {
    return FirebaseFirestore.instance
        .collection(ServiceModel.COLLECTION_NAME)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                ServiceModel.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson());
  }
  static CollectionReference<SubServiceModel> getSubServiceCollection(String serviceId) {
    return getServicesCollection()
        .doc(serviceId)
        .collection(SubServiceModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            SubServiceModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }




  Future<List<ServiceModel>> getServices() async {
    QuerySnapshot<ServiceModel> querySnapshot =
        await getServicesCollection().get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
  static Future<List<ServiceModel>> getMainServices() async {
    final snapshot = await getServicesCollection().get();
    return snapshot.docs
        .map((doc) => doc.data()).toList();
  }
  static Future<List<SubServiceModel>> getServiceSubServices(String id)async{
    print('id inside getSubServices $id');

    final snapshot = await getSubServiceCollection(id).get();
    List<SubServiceModel>subServices =  snapshot.docs
        .map((doc) => doc.data()).toList();
    print("we are here");
    for(int i=0;i<subServices.length;i++){
      print("title one ${subServices[i].title}");
    }
    return subServices;
  }
}
