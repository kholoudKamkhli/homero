import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserDatabase{
  static CollectionReference<MyUser>getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.COLLECTION_NAME).withConverter(fromFirestore: (snapshot,options)=>MyUser.fromJson(snapshot.data()!), toFirestore: (value,options)=>value.toJson());
  }
  static Future<void>addUserToDatabase(MyUser user){
    return getUsersCollection().doc(user.id).set(user);
  }
  static Future<bool> exists(String id)async{
    var user = await getUsersCollection().doc(id).get();
    if(user==null){
      return true;
    }
    else return false;
  }
  static Future<MyUser?> getUser(String id)async{
    var user = await getUsersCollection().doc(id).get();
    var myUser = user.data();
    return myUser;
  }
}