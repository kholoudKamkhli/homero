import 'package:flutter/material.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/spalsh_screens/splash_screen1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        SplashScreenOne.routeName:(_)=>SplashScreenOne(),
        HomeScreenView.routeName:(_)=>HomeScreenView(),
      } ,
      initialRoute: SplashScreenOne.routeName,
    );
  }
}

