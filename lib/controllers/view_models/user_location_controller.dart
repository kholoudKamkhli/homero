import 'package:location/location.dart';
class UserLocationController{
  Location locationManager = Location();
  Future<bool>isServiceEnabled()async{
    var isEnabled = await locationManager.serviceEnabled();
    return isEnabled;
  }
  Future<bool>requestService()async{
    var serviceEnabled = await locationManager.requestService();
    return serviceEnabled;
  }
  Future<bool>isPermessionGranted()async{
    var permessionStatus = await locationManager.hasPermission();
    if(permessionStatus==PermissionStatus.granted){
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool>requestPermession()async{
    var permessionStatus = await locationManager.requestPermission();
    return permessionStatus==PermissionStatus.granted;
  }
  Future<LocationData?>getLocation()async{
    if(! await isServiceEnabled()||! await isPermessionGranted()){
      return null;
    }
    return locationManager.getLocation();
  }
}