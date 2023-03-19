import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:homero/screens/sign_in/sign_in_view.dart';

import '../database/user_database.dart';
import '../models/user_model.dart';
import '../screens/home_screen/home_screen_view.dart';

class SignInViewModel extends ChangeNotifier{
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
    if(!await UserDatabase.check(FirebaseAuth.instance.currentUser?.uid??"")){
      MyUser user = MyUser(id: FirebaseAuth.instance.currentUser?.uid??"", username: FirebaseAuth.instance.currentUser?.displayName??"", email: FirebaseAuth.instance.currentUser?.email??"", phoneNum: FirebaseAuth.instance.currentUser?.phoneNumber??"");
      if(user.imageUrl==""){
        user.imageUrl = FirebaseAuth.instance.currentUser?.photoURL??"";
      }
      UserDatabase.addUserToDatabase(user);
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //UserDatabase.check(FirebaseAuth.instance.currentUser?.uid??"");
    if(!await UserDatabase.check(FirebaseAuth.instance.currentUser?.uid??"")){
      MyUser user = MyUser(id: FirebaseAuth.instance.currentUser?.uid??"", username: FirebaseAuth.instance.currentUser?.displayName??"", email: FirebaseAuth.instance.currentUser?.email??"", phoneNum: FirebaseAuth.instance.currentUser?.phoneNumber??"");
      if(user.imageUrl==""){
        user.imageUrl = FirebaseAuth.instance.currentUser?.photoURL??"";
      }
      UserDatabase.addUserToDatabase(user);
    }
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
  static signInWithEmailAndPassword(String mail,String password,BuildContext context)async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: password
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