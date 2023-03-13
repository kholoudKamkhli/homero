class MyUser{
  static const String COLLECTION_NAME  = "Users";
  String id;
  String username;
  String email;
  String phoneNum;
  MyUser({required this.id,required this.username,required this.email,required this.phoneNum});
  MyUser.fromJson(Map<String,dynamic>json):this(
    id:json["id"],
    username:json["username"],
    email:json["email"],
    phoneNum:json["phoneNum"]
  );
  Map<String,dynamic>toJson(){
    return {
      "id":id,
      "username":username,
      "email":email,
      "phoneNum":phoneNum,
    };
  }
}