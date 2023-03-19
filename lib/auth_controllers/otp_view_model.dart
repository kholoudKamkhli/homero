import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/user_database.dart';
import '../models/user_model.dart';
import '../screens/home_screen/home_screen_view.dart';

class OTPViewModel extends ChangeNotifier{
   static FirebaseAuth auth = FirebaseAuth.instance;
  static authenticate(String verificationId,String completeCode,String mail,String password,String username,String phone,BuildContext context)async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: completeCode);
    await auth.signInWithCredential(credential);
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      MyUser user = MyUser(id: credential.user?.uid??"", username: username, email: mail,phoneNum:phone );
      UserDatabase.addUserToDatabase(user);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreenView()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }


  }
}
