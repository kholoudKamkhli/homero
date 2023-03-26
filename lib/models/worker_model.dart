class WorkerModel{
  String name;
  String jobTitle;
  int numOfTasks;
  int numOfRatings;
  String imagePath;
  String serviceName;
  WorkerModel({required this.imagePath,required this.numOfRatings,required this.jobTitle,required this.name,required this.numOfTasks,required this.serviceName});
  WorkerModel.fromJson(Map<String,dynamic>json):this(
    name:json["name"],
    jobTitle:json["jobTitle"],
    numOfTasks:json["numOfTasks"],
    imagePath:json["imagePath"],
    numOfRatings:json["numOfRatings"],
    serviceName:json["serviceName"],

  );
  Map<String,dynamic>toJson(){
    return {
      "name":name,
      "jobTitle":jobTitle,
      "numOfTasks":numOfTasks,
      "numOfRatings":numOfRatings,
      "imagePath":imagePath,
      "serviceName":serviceName,
    };
  }
}