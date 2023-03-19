import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/otp/otp_verification.dart';
import 'package:homero/screens/profile/edit_profile.dart';
import 'package:homero/screens/sign_in/sign_in_view.dart';
import 'package:homero/screens/sign_up/sign_up_view.dart';
import 'package:homero/screens/spalsh_screens/splash_screen1.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        SplashScreenOne.routeName:(_)=>SplashScreenOne(),
        HomeScreenView.routeName:(_)=>HomeScreenView(),
        SignInView.routeName:(_)=>SignInView(),
        SignUpView.routeName:(_)=>SignUpView(),
        //OTPVerificstion.routeName:(_)=>OTPVerificstion(verificationId: verificationId)
        EditProfile.routeName:(_)=>EditProfile(),

      } ,
      initialRoute: SplashScreenOne.routeName,
      //      initialRoute: FirebaseAuth.instance.currentUser==null?SplashScreenOne.routeName:HomeScreenView.routeName,
    );
  }
}

