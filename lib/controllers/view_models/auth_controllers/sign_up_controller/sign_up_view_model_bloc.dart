import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../models/user_model.dart';
import '../../../database/user_database.dart';
class SignUpViewModelBloc extends Cubit<SignUpState> {
  SignUpViewModelBloc() : super(LoadingState());

  Future<UserCredential> signInWithFacebook() async {
    emit(LoadingState());
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
    emit(LoadedState());
    await signInWithFacebook().then((value) {
      emit(LoadedState());
    }).onError((error, stackTrace) {
      emit(ErrorState(error.toString()));
    });
  }
  Future<UserCredential?> signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    //Create a new credential
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
    //Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  signInWithGoogleFun()async{
    emit(LoadedState());
    await signInWithGoogle().then((value) {
      emit(LoadedState());
    }).onError((error, stackTrace) {
      emit(ErrorState(error.toString()));
    });
  }
  void sinInWithPhone(var completeNum,) async {
    int? _resendToken;
    emit(LoadingState());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: completeNum,
      timeout: const Duration(seconds: 120),
      forceResendingToken: _resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
      },
      verificationFailed: (FirebaseAuthException e) {
      },
      codeSent: (String verificationId, int? resendToken) {
        _resendToken = resendToken;

        emit(CodeSentState(verificationId,_resendToken));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    ).onError((error, stackTrace){
      emit(ErrorState(error.toString()));
    });
  }

}

abstract class SignUpState {}

class LoadingState extends SignUpState {}

class ErrorState extends SignUpState {
  String errorMessage;
  ErrorState(this.errorMessage);
}

class LoadedState extends SignUpState {}
class CodeSentState extends SignUpState{
  String verificationId;
  int ?resendToken;
  CodeSentState(this.verificationId,this.resendToken);
}
