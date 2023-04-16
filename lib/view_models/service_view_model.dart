import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/service_database.dart';
import '../models/service_model.dart';
class HomeViewModel extends Cubit<HomeState>{
  HomeViewModel():super(LoadingState());

  initServices()async{
    try{
      emit(ServicesLoadingState());
      List<ServiceModel>services = await ServiceDatabase.getMainServices();
      print("services loaded emit");
      emit(ServicesloadedState(services));
    }catch(e){
      emit(ServicesErrorState(e.toString()));
    }
  }

}
abstract class HomeState{}

class LoadingState extends HomeState{}
class ServicesErrorState extends HomeState{
  String errorMessage;
  ServicesErrorState(this.errorMessage);
}
class ServicesloadedState extends HomeState{
  List<ServiceModel>services;
  ServicesloadedState(this.services);
}
class ServicesLoadingState extends HomeState{}



