import 'package:flutter/material.dart';
import 'package:homero/screens/sign_up/sign_up_view.dart';

class SignInView extends StatefulWidget {
  static const String routeName = "SignUp";

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  FocusNode passwordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  var formKey = GlobalKey<FormState>();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var color = Colors.transparent;
  var hintColor = Colors.white;
  var color2 = Colors.transparent;
  var hintColor2 = Colors.white;
  bool enabled = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailFocus.addListener(() {
      if(emailFocus.hasFocus){
        setState(() {
          passwordFocus.unfocus();
          color2 = Colors.white;
          hintColor2 = Colors.grey;
          hintColor  = Colors.white;
          color= Colors.transparent;
        });
      }
      else{
        setState(() {
          color2 = Colors.transparent;
          hintColor2 = Colors.white;
        });
      }
    });

    passwordFocus.addListener(() {
      if(passwordFocus.hasFocus){
        setState(() {
          emailFocus.unfocus();
          //color2 = Colors.transparent;
          //hintColor2 = Colors.white;
          hintColor  = Colors.grey;
          color= Colors.white;
        });
      }
      else{
        setState(() {

          hintColor = Colors.white;
          color = Colors.transparent;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/img_17.png",
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/img_18.png"),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Welcome back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 18),
                              child: TextFormField(
                                controller: emailCont,
                                validator: (value) {
                                  if (value != null &&
                                      value.isNotEmpty &&
                                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return "Please enter valid Email";
                                  }
                                },
                                focusNode: emailFocus,
                                decoration: InputDecoration(

                                  focusColor:Colors.white,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: hintColor2,
                                  ),
                                  filled: true,
                                  enabled: enabled,
                                  fillColor: color2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 18),
                              child: TextFormField(
                                controller: passwordCont,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter valid Password";
                                  } else
                                    return null;
                                },
                                focusNode: passwordFocus,
                                decoration: InputDecoration(

                                  focusColor:Colors.white,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: hintColor,
                                  ),
                                  filled: true,
                                  enabled: enabled,
                                  fillColor: color,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.white),

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 60,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 18),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 18),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Login in",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 52, 205, 196),
                                ),
                              ),
                            ),
                            Text(
                              "Forgot Password",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 40),
                                Container(
                                  width: 46,
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Or sign in with",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 46,
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(onPressed: (){}, icon:Image.asset("assets/images/img_19.png") ),
                                IconButton(onPressed: (){}, icon: Image.asset("assets/images/img_21.png")),
                                IconButton(onPressed: (){}, icon: Image.asset("assets/images/img_20.png")),
                                IconButton(onPressed: (){}, icon: Image.asset("assets/images/img_22.png")),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text("Don't have an account?",style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, SignUpView.routeName);
                              },
                              child: Text("Sign up",style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 15,
                              ),),
                            )
                          ],
                        )),
                ],
              ),
            )
          ],
        ),
    );
  }
}
