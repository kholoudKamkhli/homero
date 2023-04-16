import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/orders/orders_view.dart';
import 'package:homero/screens/profile/profile_view.dart';
import 'package:homero/screens/services/services_view.dart';
import 'package:homero/screens/settings/settings_view.dart';

import '../../database/user_database.dart';
import '../home_tab_screen/home_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreenView extends StatefulWidget {
  static const String routeName = "homeScreen";

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int selectedIndex = 2;
  MyUser? user;
  var image;

  initUser() async {
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    if(user!.imageUrl==""){
      image = AssetImage("assets/images/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg");
    }
    else{
      image = NetworkImage(user!.imageUrl);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: selectedIndex == 2
                ? AppBar(
                    elevation: 0,
                    title: Image.asset(
                      "assets/images/img.png",
                      width: 83,
                      height: 21,
                    ),
                    centerTitle: false,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: () {
                        },
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 50,
                          backgroundImage: image,
                        ),
                        color: Color.fromARGB(255, 52, 205, 196),
                        onPressed: () {
                          Navigator.pushNamed(context, ProfileView.routeName);
                        },
                      ),
                    ],
              automaticallyImplyLeading: false,
                  )
                : null,
            bottomNavigationBar: BottomNavigationBar(
                //selectedItemColor: const Color.fromARGB(255, 52, 205, 196),
                type: BottomNavigationBarType.fixed,
                //backgroundColor: const Color.fromARGB(255, 217, 217, 217),
                onTap: (selected) {
                  setState(() {
                    selectedIndex = selected;
                  });
                },
                currentIndex: selectedIndex,
                items:  [
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                    icon: ImageIcon(AssetImage("assets/images/img_13.png")),
                    label: AppLocalizations.of(context)!.profile,
                  ),
                  BottomNavigationBarItem(
                    //backgroundColor: Color.fromARGB(255, 217, 217, 217),
                    icon: ImageIcon(AssetImage("assets/images/img_14.png")),
                    label: AppLocalizations.of(context)!.orders,
                  ),
                  BottomNavigationBarItem(
                    //backgroundColor: Color.fromARGB(255, 217, 217, 217),
                    icon: Icon(Icons.home),
                    label: AppLocalizations.of(context)!.home,
                  ),
                  BottomNavigationBarItem(
                    //backgroundColor: Color.fromARGB(255, 217, 217, 217),
                    icon: ImageIcon(AssetImage("assets/images/img_15.png")),
                    label: AppLocalizations.of(context)!.services,
                  ),
                  BottomNavigationBarItem(
                    //backgroundColor: Color.fromARGB(255, 217, 217, 217),
                    icon: ImageIcon(AssetImage("assets/images/img_16.png")),
                    label: AppLocalizations.of(context)!.settings,
                  ),
                ]),
            body: tabs[selectedIndex],
          );
  }

  List<Widget> tabs = [
    ProfileView(),
    OrdersView(),
    HomeTab(),
    ServicesView(),
    SettingsView()
  ];
  List<String> names = ["Profile", "Orders", "", "Services", "Settings"];
}
