import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
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

      } ,
      initialRoute: SplashScreenOne.routeName,
    );
  }
}

