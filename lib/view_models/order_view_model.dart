import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../database/order_database.dart';
import '../models/order_model.dart';

class OrderViewModel extends Cubit<OrderState>{
  List<OrderModel> orders = [];
  OrderViewModel():super(LoadingState());
  initOrders(int index) async {
    try{
      if(index==0){
        orders = await OrderDatabase.getuserAllOrders(
            FirebaseAuth.instance.currentUser!.uid);
      }
      else if (index == 1) {
        orders = await OrderDatabase.getuserScheduledOrders(
            FirebaseAuth.instance.currentUser!.uid);
      } else {
        orders = await OrderDatabase.getuserFinishedOrders(
            FirebaseAuth.instance.currentUser!.uid);
      }
      emit(LoadedState(orders: orders));
    }catch(e){
      emit(ErrorState(errorMessage:e.toString()));
    }

  }

}
abstract class OrderState{}
class LoadingState extends OrderState{}
class ErrorState extends OrderState{
  String errorMessage;
  ErrorState({required this.errorMessage});
}
class LoadedState extends OrderState{
  List<OrderModel> orders;
  LoadedState({required this.orders});
}
