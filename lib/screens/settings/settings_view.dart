import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var isSwitched = true;
  var isSwitched2 = false;
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Color.fromARGB(255, 84, 84, 84),
          ),
        ),
        leading: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text("Color Mode",style: TextStyle(
                    color: Color.fromARGB(255, 84, 84, 84),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Image.asset("assets/images/img_37.png",color: isSwitched?Color.fromARGB(
                          255, 52, 205, 196):Color.fromARGB(255, 84, 84, 84),),
                      SizedBox(width: 10,),
                      Text("Light Mode",style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),),SizedBox(width: MediaQuery.of(context).size.width*0.4,),
                      Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                        activeColor: Colors.white,
                        activeTrackColor: Color.fromARGB(255, 52, 205, 196),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.black12,
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Image.asset("assets/images/img_37.png",color: isSwitched2?Color.fromARGB(
                          255, 52, 205, 196):Color.fromARGB(255, 84, 84, 84),),
                      SizedBox(width: 10,),
                      Text("Dark Mode",style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),),
                      SizedBox(width: MediaQuery.of(context).size.width*0.4,),
                      Switch(
                        onChanged: toggleSwitch2,
                        value: isSwitched2,
                        activeColor: Colors.white,
                        activeTrackColor: Color.fromARGB(255, 52, 205, 196),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.black12,
                      )
                    ],
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),

              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Language",style: TextStyle(
                color: Color.fromARGB(255, 84, 84, 84),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              ),
            ),
        Theme(
          data: ThemeData(
            toggleableActiveColor: Color.fromARGB(255, 52, 205, 196),
          ),
          child: Column(
            children: [
              SizedBox(height: 20,),
              RadioListTile(
                title: Text('English'),
                value: 1,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
              ),
              RadioListTile(
                title: Text('Arabic'),
                value: 2,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
              ),

            ],
          ),
        )
        ],
        )
      ),
    );
  }
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched2 = false;
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch2(bool value) {
    if (isSwitched2 == false) {
      setState(() {
        isSwitched = false;
        isSwitched2 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched2 = false;
      });
      print('Switch Button is OFF');
    }
  }
  void _handleRadioValueChange(int? value) {
    setState(() {
      if(value!=null){
        _selectedValue = value;
      };
    });
  }
}
