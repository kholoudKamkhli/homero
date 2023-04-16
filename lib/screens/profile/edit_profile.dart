import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homero/controllers/user_location_controller.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/shared/dialog_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../database/user_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EditProfile extends StatefulWidget {
  static const String routeName = "editProfile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var image;
  UserLocationController locationController = UserLocationController();
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
  var formKey = GlobalKey<FormState>();
  var color = Colors.transparent;
  var hintColor = Colors.white;

  //var color2 = Colors.transparent;
  //var hintColor2 = Colors.white;
  bool enabled = true;

  Future<void> initUser() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    if(user!.imageUrl==""){
      image = AssetImage("assets/images/img_10.png");
    }
    else{
      image = NetworkImage(user!.imageUrl);
    }
    setState(() {});
  }

  @override
  void initState() {
    locationController.requestService();
    locationController.requestPermession();
    // TODO: implement initState
    super.initState();
    initUser();
    usernameFocus.addListener(() {});
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.edit_profile,
          style: Theme.of(context).appBarTheme.titleTextStyle,

        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
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
                              backgroundImage: image,

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
                      alignment: Alignment.center,
                      child:  Text(
                        AppLocalizations.of(context)!.click_to_edit,
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onTap: (){},
                        onEditingComplete: () {
                          if (usernameCont.text != null &&
                              usernameCont.text != "") {
                            user!.username = usernameCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },
                        // onSaved: (value){
                        //   print(value);
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
                          suffixIcon: Icon(
                            Icons.person_outline_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.username,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                         // hint: user!.username,
                          labelStyle: TextStyle(
                              color: usernameFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: usernameFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: usernameFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (mailCont.text != null && mailCont.text != "") {
                            user!.email = mailCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },
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
                          suffixIcon: Icon(
                            Icons.email_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.email,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          //labelText: "Email",
                          labelStyle: TextStyle(
                              color: mailFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: mailFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: mailFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (phoneNumCont.text != null &&
                              phoneNumCont.text != "") {
                            user!.phoneNum = phoneNumCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },
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
                          suffixIcon: Icon(
                            Icons.phone_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.phoneNum ?? "Phone Number",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          //labelText: "Phone Number",
                          labelStyle: TextStyle(
                              color: phoneFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: phoneFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: phoneFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                    InkWell(
                      onTap: ()async{
                          try{
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: user!.email);
                            MyDialogUtils.showAnotherMessage(context, "Activation message has been sent to your mail", "Ok");
                          }
                          catch(e){

                          }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 44,
                          width: 344,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0,bottom: 8),
                              child: Text("..........",style: TextStyle(
                                color: Colors.grey,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.lock_outline,color: Colors.grey,size:15 ,),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (locationCont.text != null &&
                              locationCont.text != "") {
                            user!.address = locationCont.text;
                            UserDatabase.editUser(user!);
                          }
                        },

                        controller: locationCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid location";
                          } else {
                            return null;
                          }
                        },
                        focusNode: locationFocus,
                        decoration: InputDecoration(
                          //suffixIcon: ImageIcon(AssetImage("assets/images/img_34.png"),color: Colors.grey,size: 9,),
                          suffixIcon: Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: user!.address??"location",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          //labelText: "Location",
                          labelStyle: TextStyle(
                              color: locationFocus.hasFocus
                                  ? Colors.tealAccent
                                  : Colors.grey),
                          filled: true,
                          enabled: true,
                          fillColor: locationFocus.hasFocus
                              ? Colors.transparent
                              : Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: locationFocus.hasFocus
                                    ? Colors.tealAccent
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.tealAccent),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
    );
  }
  // Future<Address?> getUserLocation()async{
  //   bool isServiceEnabled =await locationController.requestService();
  //   bool isPermessionGranted = await locationController.requestPermession();
  //   if(isServiceEnabled&&isPermessionGranted){
  //     var locationData = await locationController.getLocation();
  //     final coordinates = new Coordinates(locationData?.latitude, locationData?.longitude);
  //     var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //     var first = address.first;
  //     return first;
  //   }
  // }
}
