import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/sign_in/sign_in_view_model.dart';
import 'package:homero/screens/sign_up/sign_up_view.dart';

import '../../database/user_database.dart';
import '../../models/user_model.dart';

class SignInView extends StatefulWidget {
  static const String routeName = "SignUp";

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late var viewModel;
  FocusNode passwordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  var formKey = GlobalKey<FormState>();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var color = Colors.transparent;
  var hintColor = Colors.white;
  var color2 = Colors.transparent;
  var hintColor2 = Colors.white;
  bool enabled = true;

  @override
  void initState() {
    viewModel=SignInViewModel();
    // TODO: implement initState
    super.initState();
    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        setState(() {
          passwordFocus.unfocus();
          color2 = Colors.white;
          hintColor2 = Colors.grey;
          hintColor = Colors.white;
          color = Colors.transparent;
        });
      } else {
        setState(() {
          color2 = Colors.transparent;
          hintColor2 = Colors.white;
        });
      }
    });

    passwordFocus.addListener(() {
      if (passwordFocus.hasFocus) {
        setState(() {
          emailFocus.unfocus();
          //color2 = Colors.transparent;
          //hintColor2 = Colors.white;
          hintColor = Colors.grey;
          color = Colors.white;
        });
      } else {
        setState(() {
          hintColor = Colors.white;
          color = Colors.transparent;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/img_17.png",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/img_18.png"),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Welcome back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 18),
                          child: TextFormField(
                            controller: emailCont,
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
                            focusNode: emailFocus,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: hintColor2,
                              ),
                              filled: true,
                              enabled: enabled,
                              fillColor: color2,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 18),
                          child: TextFormField(
                            controller: passwordCont,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid Password";
                              } else {
                                return null;
                              }
                            },
                            focusNode: passwordFocus,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: hintColor,
                              ),
                              filled: true,
                              enabled: enabled,
                              fillColor: color,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            validateForm();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 18),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 18),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 52, 205, 196),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Container(
                              width: 46,
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Or sign in with",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 46,
                              height: 1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: ()async {
                                  try{
                                    await signInWithFacebook();
                                    if(FirebaseAuth.instance.currentUser!=null){
                                      Navigator.pushReplacementNamed(context, HomeScreenView.routeName);
                                    }
                                  }
                                  catch(e){

                                  }
                                },
                                icon: Image.asset("assets/images/img_19.png")),
                            IconButton(
                                onPressed: () async{
                                  try{
                                    await signInWithGoogle();
                                    if(FirebaseAuth.instance.currentUser!=null){
                                      Navigator.pushReplacementNamed(context, HomeScreenView.routeName);
                                    }
                                  }
                                  catch(e){

                                  }
                                },
                                icon: Image.asset("assets/images/img_21.png")),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset("assets/images/img_20.png")),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset("assets/images/img_22.png")),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                       const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SignUpView.routeName);
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void validateForm() async{
    if(formKey.currentState!.validate()){
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailCont.text,
            password: passwordCont.text
        );
        //MyUser? user = await UserDatabase.getUser(credential.user?.uid ?? "");

          Navigator.pushReplacementNamed(context, HomeScreenView.routeName);
          return;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    MyUser user = MyUser(id: FirebaseAuth.instance.currentUser?.uid??"", username: FirebaseAuth.instance.currentUser?.displayName??"", email: FirebaseAuth.instance.currentUser?.email??"", phoneNum: FirebaseAuth.instance.currentUser?.phoneNumber??"");
    UserDatabase.addUserToDatabase(user);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);
    UserDatabase.check(FirebaseAuth.instance.currentUser?.uid??"");
    print("we are inside facebook");
    if(!await UserDatabase.check(FirebaseAuth.instance.currentUser?.uid??"")){
      MyUser user = MyUser(id: FirebaseAuth.instance.currentUser?.uid??"", username: FirebaseAuth.instance.currentUser?.displayName??"", email: FirebaseAuth.instance.currentUser?.email??"", phoneNum: FirebaseAuth.instance.currentUser?.phoneNumber??"");
      if(user.imageUrl==""){
        user.imageUrl = FirebaseAuth.instance.currentUser?.photoURL??"";
      }
      UserDatabase.addUserToDatabase(user);
    }
    // MyUser user = MyUser(id: FirebaseAuth.instance.currentUser?.uid??"", username: FirebaseAuth.instance.currentUser?.displayName??"", email: FirebaseAuth.instance.currentUser?.email??"", phoneNum: FirebaseAuth.instance.currentUser?.phoneNumber??"");
    // if(user.imageUrl==""){
    //   user.imageUrl = FirebaseAuth.instance.currentUser?.photoURL??"";
    // }
    // UserDatabase.addUserToDatabase(user);
    print("after database");

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
