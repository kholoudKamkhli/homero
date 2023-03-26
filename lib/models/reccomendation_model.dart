class RecommendationModel{
  static const String COLLECTION_NAME  = "Recommendations";
  String title;
  String latestReview;
  String imagePath;
  RecommendationModel({required this.title,required this.imagePath,required this.latestReview});
  RecommendationModel.fromJson(Map<String,dynamic>json):this(
      title:json["title"],
      latestReview:json["latestReview"],
      imagePath:json["imagePath"],
  );
  Map<String,dynamic>toJson(){
    return {
      "title":title,
      "latestReview":latestReview,
      "imagePath":imagePath,
    };
  }
}