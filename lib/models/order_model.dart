import 'package:homero/models/service_model.dart';
import 'package:homero/models/worker_model.dart';

class OrderModel{
  static const String COLLECTION_NAME = "Orders";
  String fullName;
  String mobileNum;
  String location;
  DateTime date;
  String area;
  int numOfRoom;
  String scheduling;
  bool isFinished;
  bool isScheduled;
  String serviceName;
  double cost;
  String? uId;
  OrderModel({required this.cost,this.uId,required this.serviceName,required this.location,required this.date,required this.area,required this.fullName,required this.isFinished,required this.isScheduled,required this.mobileNum,required this.numOfRoom,required this.scheduling});
  OrderModel.fromJson(Map<String,dynamic>json):this(
    uId:json["uId"],
    cost:json["cost"],
    serviceName:json["serviceName"],
    fullName:json["fullName"],
    mobileNum:json["mobileNum"],
    location:json["location"],
    date:DateTime.fromMillisecondsSinceEpoch(json['DateTime']),
    area:json["area"],
    numOfRoom:json["numOfRoom"],
    scheduling:json["scheduling"],
    isFinished:json["isFinished"],
    isScheduled:json["isScheduled"],

  );
  Map<String,dynamic>toJson(){
    return {
      "uId":uId,
      "serviceName":serviceName,
      "cost":cost,
      "fullName":fullName,
      "location":location,
      "mobileNum":mobileNum,
      "date":date.millisecondsSinceEpoch,
      "area":area,
      "numOfRoom":numOfRoom,
      "scheduling":scheduling,
      "isFinished":isFinished,
      "isScheduled":isScheduled,
    };
  }

}