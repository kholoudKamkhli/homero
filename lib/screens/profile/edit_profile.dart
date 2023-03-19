import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homero/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../database/user_database.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "editProfile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var usernameCont = TextEditingController();
  var mailCont = TextEditingController();
  var phoneNumCont = TextEditingController();
  var passwordCont = TextEditingController();
  var locationCont = TextEditingController();
  MyUser? user;
  FocusNode usernameFocus = FocusNode();
  FocusNode mailFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode locationFocus = FocusNode();
  var color = Colors.transparent;
  var hintColor = Colors.white;
  //var color2 = Colors.transparent;
  //var hintColor2 = Colors.white;
  bool enabled = true;
  Future<void> initUser() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
    usernameFocus.addListener(() {
    });
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    _image = image;
    print(_image?.path ?? "null path");
    if (_image != null) {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceImages = referenceRoot.child('images');
      Reference referenceImageToUpload = referenceImages.child(_image!.path);
      try {
        await referenceImageToUpload.putFile(File(_image!.path));
        String imageUrl = await referenceImageToUpload.getDownloadURL();
        user!.imageUrl = imageUrl;
        await UserDatabase.updateImage(user!, imageUrl);
      } catch (error) {}
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(
          color: Color.fromARGB(255, 84, 84, 84),
        ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 84, 84, 84)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   SizedBox(height: 30,),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: user!.imageUrl == ""
                                  ? Image.asset(
                                      "assets/images/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg")
                                  : Image.network(
                                      user!.imageUrl,
                                    ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                "assets/images/img_33.png",
                                height: 32,
                                width: 32,
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      "Click for edit",
                      style: TextStyle(
                        color: Color.fromARGB(255, 126, 127, 131),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      // onEditingComplete: (){
                      //   user!.username = usernameCont.text;
                      // },
                      // onSaved: (value){
                      //   if(value!=null&&value.isNotEmpty){
                      //     user!.username = value;
                      //   }
                      //
                      // },
                      controller: usernameCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid name";
                        } else {
                          return null;
                        }
                      },
                      focusNode: usernameFocus,
                      decoration: InputDecoration(
                        //suffixIcon: ImageIcon(AssetImage("assets/images/img_34.png"),color: Colors.grey,size: 9,),
                        suffixIcon: Icon(Icons.person_outline_outlined,size: 15,color: Colors.grey,),
                        focusColor: Colors.transparent,
                        hintText: user!.username,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        labelText: "Full Name ",
                        labelStyle: TextStyle(
                          color:usernameFocus.hasFocus?Colors.tealAccent:Colors.grey
                        ),
                        filled: true,
                        enabled: true,
                        fillColor: usernameFocus.hasFocus?Colors.transparent:Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: usernameFocus.hasFocus?Colors.tealAccent:Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                           BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: mailCont,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return null;
                        } else {
                          return "Please enter valid Email";
                        }
                      },
                      focusNode: mailFocus,
                      decoration: InputDecoration(
                        //suffixIcon: ImageIcon(AssetImage("assets/images/img_34.png"),color: Colors.grey,size: 9,),
                        suffixIcon: Icon(Icons.email_outlined,size: 15,color: Colors.grey,),
                        focusColor: Colors.transparent,
                        hintText: user!.email,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color:usernameFocus.hasFocus?Colors.tealAccent:Colors.grey
                        ),
                        filled: true,
                        enabled: true,
                        fillColor: usernameFocus.hasFocus?Colors.transparent:Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: usernameFocus.hasFocus?Colors.tealAccent:Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: phoneNumCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter phone number";
                        } else {
                          return null;
                        }
                      },
                      focusNode: phoneFocus,
                      decoration: InputDecoration(
                        //suffixIcon: ImageIcon(AssetImage("assets/images/img_34.png"),color: Colors.grey,size: 9,),
                        suffixIcon: Icon(Icons.phone_outlined,size: 15,color: Colors.grey,),
                        focusColor: Colors.transparent,
                        hintText: user!.phoneNum??"",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                            color:usernameFocus.hasFocus?Colors.tealAccent:Colors.grey
                        ),
                        filled: true,
                        enabled: true,
                        fillColor: usernameFocus.hasFocus?Colors.transparent:Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: usernameFocus.hasFocus?Colors.tealAccent:Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 44,
                    child: TextFormField(
                      controller: passwordCont,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter valid name";
                        } else {
                          return null;
                        }
                      },
                      focusNode: passwordFocus,
                      obscureText: true,
                      obscuringCharacter: ".",
                      decoration: InputDecoration(
                        //suffixIcon: ImageIcon(AssetImage("assets/images/img_34.png"),color: Colors.grey,size: 9,),
                        suffixIcon: Icon(Icons.lock_outline,size: 15,color: Colors.grey,),
                        focusColor: Colors.transparent,
                        hintText: ".......",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color:usernameFocus.hasFocus?Colors.tealAccent:Colors.grey
                        ),
                        filled: true,
                        enabled: true,
                        fillColor: usernameFocus.hasFocus?Colors.transparent:Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: usernameFocus.hasFocus?Colors.tealAccent:Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                          BorderSide(color: Colors.tealAccent),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
