import 'package:flutter/material.dart';
import 'package:homero/screens/home_tab_screen/ad_widget.dart';
import 'package:homero/screens/home_tab_screen/package_widget.dart';
import 'package:homero/screens/home_tab_screen/recommended_widget.dart';
import 'package:homero/screens/home_tab_screen/service_widget.dart';
import 'package:homero/screens/orders/orders_view.dart';
import 'package:homero/screens/profile/profile_view.dart';
import 'package:homero/screens/services/services_view.dart';
import 'package:homero/screens/settings/settings_view.dart';

import '../home_tab_screen/home_tab.dart';

class HomeScreenView extends StatefulWidget {
  static const String routeName = "homeScreen";

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/img_1.png"),
              color: Color.fromARGB(255, 52, 205, 196),
            ),
            onPressed: () {
              // do something
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 52, 205, 196),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 217, 217, 217),
          onTap: (selected){

            setState(() {
              selectedIndex = selected;
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 217, 217, 217),
              //backgroundColor: Theme.of(context).primaryColor,
              icon: ImageIcon(AssetImage("assets/images/img_13.png")),
              label: "profile",),
            BottomNavigationBarItem(
              //backgroundColor: Color.fromARGB(255, 217, 217, 217),
              icon: ImageIcon(AssetImage("assets/images/img_14.png")),
              label: "Orders",),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 217, 217, 217),
              icon:const Icon(Icons.home),
              label: "Home",),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 217, 217, 217),
              icon: ImageIcon(AssetImage("assets/images/img_15.png")),
              label: "Services",),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 217, 217, 217),
              icon: const ImageIcon(AssetImage("assets/images/img_16.png")),
              label: "Settings",),
          ]
      ),
      body: tabs[selectedIndex],
    );
  }
  List<Widget> tabs = [ProfileView(),OrdersView(),HomeTab(),ServicesView(),SettingsView()];
}
