
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../database/user_database.dart';
import '../../../models/user_model.dart';
import '../../../screens/home_screen/home_screen_view.dart';

class SignInViewModelBloc extends Cubit<SignInState> {
  SignInViewModelBloc() : super(LoadingState());

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    UserDatabase.check(FirebaseAuth.instance.currentUser?.uid ?? "");
    if (!await UserDatabase.check(
        FirebaseAuth.instance.currentUser?.uid ?? "")) {
      MyUser user = MyUser(
          id: FirebaseAuth.instance.currentUser?.uid ?? "",
          username: FirebaseAuth.instance.currentUser?.displayName ?? "",
          email: FirebaseAuth.instance.currentUser?.email ?? "",
          phoneNum: FirebaseAuth.instance.currentUser?.phoneNumber ?? "");
      if (user.imageUrl == "") {
        user.imageUrl = FirebaseAuth.instance.currentUser?.photoURL ?? "";
      }
      UserDatabase.addUserToDatabase(user);
    }

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  signInWithFacebookFun() async {
    await signInWithFacebook().then((value) {
      emit(LoadedState());
    }).onError((error, stackTrace) {
      emit(ErrorState(error.toString()));
    });
  }
  signInWithEmailAndPassword(String mail,String password,BuildContext context)async {
    try {
      emit(LoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: password
      );
      //MyUser? user = await UserDatabase.getUser(credential.user?.uid ?? "");
      emit(LoadedState());
      return;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ErrorState("User Not Found"));
      } else if (e.code == 'wrong-password') {
        emit(ErrorState('Wrong password provided for that user.'));
      }
    }
  }
}

abstract class SignInState {}

class LoadingState extends SignInState {}

class ErrorState extends SignInState {
  String errorMessage;
  ErrorState(this.errorMessage);
}

class LoadedState extends SignInState {}
