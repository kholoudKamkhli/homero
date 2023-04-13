class ServiceModel {
  static const String COLLECTION_NAME = "mainServices";
  String id;
  String title;
  String imageUrl;
  String? docID;
  ServiceModel({
    docID = "",
    required this.id,
    required this.title,
    required this.imageUrl,
  });
  ServiceModel.fromJson(Map<String, dynamic> json)
      : this(id: json["id"], title: json["title"], imageUrl: json["imageUrl"], docID: json["docID"]);
  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "imageUrl": imageUrl, "docID": docID};
  }
}

class SubServiceModel {
  static const String COLLECTION_NAME = "subServices";
  String id;
  String title;
  String imageUrl;
  double cost;
  SubServiceModel({required this.id, required this.title, required this.imageUrl, required this.cost});
  SubServiceModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          imageUrl: json["imageUrl"],
          cost: double.parse(json["cost"].toString()),
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "imageUrl": imageUrl,
      "cost": cost,
    };
  }
}
