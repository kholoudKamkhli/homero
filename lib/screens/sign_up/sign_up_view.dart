import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homero/database/user_database.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/otp/otp_verification.dart';
import 'package:homero/screens/sign_up/sign_un_view_model.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../home_screen/home_screen_view.dart';

class SignUpView extends StatefulWidget {
  static const String routeName = "SignUp";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late var viewModel;
  var formKey = GlobalKey<FormState>();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var numberCont = TextEditingController();
  var nameCont = TextEditingController();
  var completeNum;

  bool valuefirst = false;

  bool valuesecond = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = SignUpViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/img_24.png",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Form(
            key: formKey,
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/img_23.png",
                    width: 37,
                    height: 64,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 84, 84),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 327,
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black45)),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            "Full name",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: nameCont,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter valid name";
                                } else {
                                  return null;
                                }
                              },
                              cursorHeight: 0,
                              cursorWidth: 0,
                              decoration:
                              const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 327,
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black45)),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: emailCont,
                              validator: (value) {
                                if (value != null &&
                                    value.isNotEmpty &&
                                    RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return null;
                                } else {
                                  return "Please enter valid Email";
                                }
                              },
                              cursorHeight: 0,
                              cursorWidth: 0,
                              decoration:
                              const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 327,
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black45)),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            "Password",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: passwordCont,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              cursorHeight: 0,
                              cursorWidth: 0,
                              decoration:
                              const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, right: 5),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    width: 327,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Color.fromARGB(255, 126, 127, 131)),
                    ),
                    child: IntlPhoneField(
                      controller: numberCont,
                      decoration: InputDecoration(

                        hintText: 'Phone Number',
                        border: InputBorder.none,
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        completeNum = phone.completeNumber;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      validateForm();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 327,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 52, 205, 196),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Sign In",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 84, 84, 84)),
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 35, top: 18),
                        child: Checkbox(
                            value: valuesecond,
                            //fillColor: MaterialStateProperty.resolveWith((states) => null),
                            activeColor: Colors.transparent,
                            checkColor: const Color.fromARGB(255, 84, 84, 84),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null) valuesecond = value;
                              });
                            }),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.symmetric(vertical: 18),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        child: const Text(
                          "By creating your account on Homero agree to the Terms of Uses, Conditions & Privacy Policies",
                          style: TextStyle(
                            color: Color.fromARGB(255, 84, 84, 84),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 46,
                        height: 1,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 84, 84, 84),
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
                            color: Color.fromARGB(255, 84, 84, 84)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 46,
                        height: 1,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 84, 84, 84),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () async {
                            try {
                              await SignUpViewModel.signInWithFacebook();
                              if (FirebaseAuth.instance.currentUser != null) {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreenView.routeName);
                              }
                            }
                            catch (e) {

                            }
                          },
                          icon: Image.asset("assets/images/img_26.png")),
                      IconButton(
                          onPressed: () async {
                            try {
                              await SignUpViewModel.signInWithGoogle();
                              if (FirebaseAuth.instance.currentUser != null) {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreenView.routeName);
                              }
                            }
                            catch (e) {

                            }
                          },
                          icon: Image.asset("assets/images/img_28.png")),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/images/img_27.png")),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/images/img_29.png")),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void sinInWithPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: completeNum,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                OTPVerificstion(verificationId: verificationId,
                  mail: emailCont.text,
                  password: passwordCont.text,phone:numberCont.text,username:completeNum)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      sinInWithPhone();
    }
  }
}
