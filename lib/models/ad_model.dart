class AdModel{
  static const String COLLECTION_NAME  = "Ads";
  String title;
  String imagePath;
  String backgroundImagePath;
  AdModel({required this.title,required this.imagePath,required this.backgroundImagePath});
  AdModel.fromJson(Map<String,dynamic>json):this(
      title:json["title"],
      imagePath:json["imagePath"],
      backgroundImagePath:json["backgroundImagePath"],
  );
  Map<String,dynamic>toJson(){
    return {
      "title":title,
      "imagePath":imagePath,
      "backgroundImagePath":backgroundImagePath
    };
  }
}