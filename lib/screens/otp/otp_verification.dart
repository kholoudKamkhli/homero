import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';

class OTPVerificstion extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final String verificationId;

  OTPVerificstion({required this.verificationId});

  var codeCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          children: [
            TextFormField(
              controller: codeCont,
              decoration: InputDecoration(
                hintText: "Enter OTP",
              ),
            ),
            InkWell(
                onTap: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: codeCont.text);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);
                  if (auth.currentUser != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreenView()));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Send"),
                ))
          ],
        )),
      ),
    );
  }
}
