import 'package:flutter/material.dart';
import 'package:homero/controllers/auth_controllers/settings/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen/home_screen_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingsView extends StatefulWidget {
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var isSwitched = true;
  var isSwitched2 = false;
  int _selectedValue = 1;
   SharedPreferences ?prefs;
  initPref()async{
    prefs = await SharedPreferences.getInstance();
    setState(() {

    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPref();

  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);

    return prefs==null?Center(child: CircularProgressIndicator(),):Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomeScreenView.routeName),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: TextStyle(
                    color: Color.fromARGB(255, 84, 84, 84),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/img_37.png",
                      color: isSwitched
                          ? Color.fromARGB(255, 52, 205, 196)
                          : Color.fromARGB(255, 84, 84, 84),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.light,
                      style: Theme.of(context).textTheme.bodyLarge,

                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Switch(
                      onChanged: (value) {
                        if (isSwitched == false) {
                          setState(() {
                            isSwitched2 = false;
                            isSwitched = true;
                            settingsProvider.changeTheme(ThemeMode.light);
                          });
                          print('Switch Button is ON');
                        } else {
                          setState(() {
                            isSwitched2 = true;
                            isSwitched = false;
                            settingsProvider.changeTheme(ThemeMode.dark);

                          });
                          print('Switch Button is OFF');
                        }
                      },
                      value: isSwitched,
                      activeColor: Colors.white,
                      activeTrackColor: Color.fromARGB(255, 52, 205, 196),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.black12,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/img_37.png",
                      color: isSwitched2
                          ? Color.fromARGB(255, 52, 205, 196)
                          : Color.fromARGB(255, 84, 84, 84),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.dark,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    Switch(
                      onChanged: (value) {
                        if (isSwitched2 == false) {
                          setState(() {
                            isSwitched = false;
                            isSwitched2 = true;
                            settingsProvider.changeTheme(ThemeMode.dark);

                          });
                          print('Switch Button is ON');
                        } else {
                          setState(() {
                            isSwitched = true;
                            isSwitched2 = false;
                            settingsProvider.changeTheme(ThemeMode.light);

                          });
                          print('Switch Button is OFF');
                        }
                      },
                      value: isSwitched2,
                      activeColor: Colors.white,
                      activeTrackColor: Color.fromARGB(255, 52, 205, 196),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.black12,
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
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
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    settingsProvider.changeLocale("en");
                  },
                  child: RadioListTile(
                    title: Text(AppLocalizations.of(context)!.english,style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    value: 1,
                    groupValue: prefs!.getInt("_selectedValue"),
                    onChanged: (int ?value){
                      setState(() {
                        if (value != null) {
                          _selectedValue = value;
                          prefs!.setInt("_selectedValue", value);
                          settingsProvider.changeLocale("en");
                          print(settingsProvider.isArabic());
                          print(AppLocalizations.of(context)!.settings);
                        }
                        ;
                      });
                    },
                  ),
                ),
                InkWell(
                  onTap: (){
                    settingsProvider.changeLocale("ar");
                    print(settingsProvider.isArabic());
                  },
                  child: RadioListTile(
                    title: Text(AppLocalizations.of(context)!.arabic,style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    value: 2,
                    groupValue: prefs!.getInt("_selectedValue"),
                    onChanged: (int ?value){
                      setState(() {
                        if (value != null) {
                          _selectedValue = value;
                          prefs!.setInt("_selectedValue", value);
                          settingsProvider.changeLocale("ar");
                          print(settingsProvider.isArabic());
                          print(AppLocalizations.of(context)!.settings);
                        }
                        ;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      )),
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
        isSwitched2 = true;
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
        isSwitched = true;
        isSwitched2 = false;
      });
      print('Switch Button is OFF');
    }
  }

  void _handleRadioValueChange(int? value)async {
    setState(() {

      if (value != null) {
        _selectedValue = value;
        prefs!.setInt("_selectedValue", value);
      }
      else{
        _selectedValue = 1;
      }
      ;
    });
  }
}
