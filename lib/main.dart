import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/otp/otp_verification.dart';
import 'package:homero/screens/payment/payment_view.dart';
import 'package:homero/screens/profile/edit_profile.dart';
import 'package:homero/screens/sign_in/sign_in_view.dart';
import 'package:homero/screens/sign_up/sign_up_view.dart';
import 'package:homero/screens/spalsh_screens/splash_screen1.dart';
import 'package:homero/screens/workers/worker_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = "pk_test_51Mg3P2Lfuo7YOusxbCq7QqHZmV7c8JaTHeEXKSVG7F7wAhKO86GaZF3BagsybszMEXrp3pDoFGan25JPsPvoOOau00WNmCStr1";
  await dotenv.load(fileName: "assets/.env");
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
        WorkerView.routeName:(_)=>WorkerView(),
        PaymentView.routeName:(_)=>PaymentView(),

      } ,
      initialRoute: SplashScreenOne.routeName,
      //      initialRoute: FirebaseAuth.instance.currentUser==null?SplashScreenOne.routeName:HomeScreenView.routeName,
    );
  }
}

