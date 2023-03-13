import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
static const String routeName = "SignUp";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();
  var numberCont = TextEditingController();
  var nameCont = TextEditingController();

bool valuefirst = false;

bool valuesecond = false;

@override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/img_24.png",
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
                Image.asset("assets/images/img_23.png",width: 37,height: 64,),
                SizedBox(height: 10,),
                const Text("Sign Up",style: TextStyle(
                  color: Color.fromARGB(255, 84, 84, 84),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 327,
                  height: 70,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black45)
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: Text("Full name",style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),textAlign: TextAlign.start,),
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            controller: nameCont,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter valid name";
                              } else
                                return null;
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            decoration: InputDecoration(
                              border: InputBorder.none

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 327,
                  height: 70,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black45)
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: Text("Email",style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),textAlign: TextAlign.start,),
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
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
                            cursorHeight: 0,
                            cursorWidth: 0,
                            decoration: InputDecoration(
                                border: InputBorder.none

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 327,
                  height: 70,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black45)
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: Text("Password",style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),textAlign: TextAlign.start,),
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            controller: passwordCont,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password can't be empty";
                              } else
                                return null;
                            },
                            cursorHeight: 0,
                            cursorWidth: 0,
                            decoration: InputDecoration(
                                border: InputBorder.none

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 327,
                  height: 70,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black45)
                  ),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: Text("Mobile Number",style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),textAlign: TextAlign.start,),
                      ),
                      SizedBox(
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: TextFormField(
                            controller: numberCont,
                            validator: (value) {
                              if (value != null &&
                                  value.isNotEmpty &&
                                  RegExp("^01[0125][0-9]{8}")
                                      .hasMatch(value)) {
                                return null;
                              } else {
                                return "Please enter valid mobile number";
                              }
                            },
                            keyboardType: TextInputType.number,
                            cursorHeight: 0,
                            cursorWidth: 0,
                            decoration: InputDecoration(
                              prefixIcon: Image.asset("assets/images/img_25.png",height:18 ,width: 18,),
                                border: InputBorder.none

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 327,
                  margin: EdgeInsets.symmetric(
                      horizontal: 50, vertical: 18),
                  padding: EdgeInsets.symmetric(
                      horizontal: 15, vertical: 18),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 52, 205, 196),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 84, 84, 84)),
                ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(
                          left: 35, top: 18),
                      child: Checkbox(
                          value: this.valuesecond,
                          //fillColor: MaterialStateProperty.resolveWith((states) => null),
                          activeColor: Colors.transparent,
                          checkColor: Color.fromARGB(255, 84, 84, 84),
                          onChanged: (bool ?value){
                            setState(() {
                              if(value!=null)
                                valuesecond = value;
                            });
                          }),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.symmetric(vertical: 18),
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Text("By creating your account on Homero agree to the Terms of Uses, Conditions & Privacy Policies",style: TextStyle(
                        color: Color.fromARGB(255, 84, 84, 84),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: 46,
                      height: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 84, 84, 84),
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
                          color: Color.fromARGB(255, 84, 84, 84)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 46,
                      height: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 84, 84, 84),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      loginWithFacebook();
                    }, icon:Image.asset("assets/images/img_26.png") ),
                    IconButton(onPressed: (){}, icon: Image.asset("assets/images/img_28.png")),
                    IconButton(onPressed: (){}, icon: Image.asset("assets/images/img_27.png")),
                    IconButton(onPressed: (){}, icon: Image.asset("assets/images/img_29.png")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void loginWithFacebook() {}
}
