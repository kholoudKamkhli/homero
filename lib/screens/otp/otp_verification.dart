import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../controllers/auth_controllers/otp_view_model.dart';

class OTPVerificstion extends StatelessWidget {
  static const String routeName = "OTP";
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String verificationId;
  String mail;
  String password;
  String phone;
  late String completeCode;
  String username;
  var cont1 = TextEditingController();
  var cont2 = TextEditingController();
  var cont3 = TextEditingController();
  var cont4 = TextEditingController();
  var cont5 = TextEditingController();
  var cont6 = TextEditingController();
  var formKey = GlobalKey<FormState>();
  OTPVerificstion({required this.verificationId,required this.mail,required this.password,required this.phone,required this.username});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<OTPViewModel>(
          create: (_)=>OTPViewModel(),
          child: Stack(
      alignment: Alignment.center,
      children: [
          Image.asset(
            "assets/images/img_30.png",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/img_23.png",
                width: 37,
                height: 64,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 20),
                child: Text(
                  "Account Verification",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment:Alignment.center,
                      margin: const EdgeInsets.only(left: 5),
                      height: 64,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color.fromARGB(255, 84, 84, 84))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "code can't be empty";
                            }
                            else return null;
                          },
                          controller: cont1,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment:Alignment.center,
                      margin: const EdgeInsets.only(left: 5),
                      height: 64,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color.fromARGB(255, 84, 84, 84))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "code can't be empty";
                            }
                            else return null;
                          },
                          controller: cont2,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 64,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color.fromARGB(255, 84, 84, 84))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "code can't be empty";
                            }
                            else return null;
                          },
                          controller: cont3,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 64,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color.fromARGB(255, 84, 84, 84))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "code can't be empty";
                            }
                            else return null;
                          },
                          controller: cont4,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 64,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color.fromARGB(255, 84, 84, 84))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "code can't be empty";
                            }
                            else return null;
                          },
                          controller: cont5,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 64,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: const Color.fromARGB(255, 84, 84, 84))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "code can't be empty";
                            }
                            else return null;
                          },
                          controller: cont6,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Row(
                  children: const [
                    Text(
                      "Resend OTP after 2 minutes",
                      style: TextStyle(
                        color: Color.fromARGB(255, 126, 127, 131),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "Resend",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 14),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  if(formKey.currentState!.validate()){
                    completeCode="${cont1.text}${cont2.text}${cont3.text}${cont4.text}${cont5.text}${cont6.text}";
                    OTPViewModel.authenticate(verificationId, completeCode, mail, password, username, phone, context);
                    // completeCode="${cont1.text}${cont2.text}${cont3.text}${cont4.text}${cont5.text}${cont6.text}";
                    // //print(completeCode);
                    // PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    //     verificationId: verificationId, smsCode: completeCode);
                    //
                    // // Sign the user in (or link) with the credential
                    // await auth.signInWithCredential(credential);
                    //   try {
                    //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    //       email: mail,
                    //       password: password,
                    //     );
                    //     MyUser user = MyUser(id: credential.user?.uid??"", username: username, email: mail,phoneNum:phone );
                    //     UserDatabase.addUserToDatabase(user);
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => HomeScreenView()));
                    //   } on FirebaseAuthException catch (e) {
                    //     if (e.code == 'weak-password') {
                    //       print('The password provided is too weak.');
                    //     } else if (e.code == 'email-already-in-use') {
                    //       print('The account already exists for that email.');
                    //     }
                    //   } catch (e) {
                    //     print(e);
                    //   }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 327,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 52, 205, 196),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    ),
        ));
  }
}
