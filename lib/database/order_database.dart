import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homero/models/order_model.dart';

class OrderDatabase{
  static CollectionReference<OrderModel> getOrdersCollection() {
    return FirebaseFirestore.instance
        .collection(OrderModel.COLLECTION_NAME)
        .withConverter(
        fromFirestore: (snapshot, options) =>
            OrderModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }
  static Future<void>addOrder(OrderModel order){
    return getOrdersCollection().doc().set(order);


  }
}