import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/worker_model.dart';

class WorkerDatabase {
  static CollectionReference<WorkerModel> getWorkersCollection() {
    return FirebaseFirestore.instance
        .collection(WorkerModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            WorkerModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  
  static Future<List<WorkerModel>> getWorkersss(String serviceName) async {
    var querySnapshot = await getWorkersCollection().where('serviceName',isEqualTo: serviceName).get();
    print("service size ${querySnapshot.size}");
    print("service name $serviceName");
    print("hfghghg ${querySnapshot.docs.map((doc)=>doc.data()).toList()}");
    return querySnapshot.docs.map((doc)=>doc.data()).toList();
  }
  static Future<List<WorkerModel>> getWorkers(String serviceName)async{
    print('id inside getSubServices $serviceName');

    final snapshot = await getWorkersCollection().get();
    List<WorkerModel>workers =  snapshot.docs
        .map((doc) => doc.data()).toList();
     print(workers.length);
    return workers;
  }

}
