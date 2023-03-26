import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:homero/database/user_database.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/sign_in/sign_in_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'edit_profile.dart';
class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  MyUser ? user;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    initUser();

  }
  Future<void> initUser() async {
    print("we are initting user");
    print(FirebaseAuth.instance.currentUser!.uid);
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    setState(() {

    });
  }
  final ImagePicker _picker = ImagePicker();
  XFile? _image ;
  @override
  Widget build(BuildContext context) {
    return user==null?Center(child: CircularProgressIndicator(),):Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user!.imageUrl == ""
                  ? "assets/images/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg"
                  : user!.imageUrl),

            ),
            ),
          const SizedBox(
            height: 20,
          ),
           Text(
            user!.username,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, EditProfile.routeName);
            },
            child: const Text(
              "Edit Profile",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color.fromARGB(255, 126, 127, 131),
                  fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: 328,
            height: 1,
            decoration:const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                     Icons.notifications_none,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 115,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.menu_book_outlined,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "My orders",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 125,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.library_books,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Schedule",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.wallet,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Wallet",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.payment,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
          Container(
            width: 270,
            height: 1,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 126, 127, 131),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap:(){
                      //FirebaseAuth.instance.signOut();
                      //Navigator.pushReplacementNamed(context, SignInView.routeName);
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Color.fromARGB(255, 84, 84, 84),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 145,
                  ),
                  const Icon(Icons.navigate_next,
                      color: Color.fromARGB(255, 84, 84, 84))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
