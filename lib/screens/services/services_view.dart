import 'package:flutter/material.dart';

import '../home_tab_screen/service_widget.dart';

class ServicesView extends StatelessWidget {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "What Services Are You Looking For?",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<ServiceWidget> services = [
    ServiceWidget(
        title: "Cleaning", imagePath: Image.asset("assets/images/img_6.png")),
    ServiceWidget(
        title: "Cooking", imagePath: Image.asset("assets/images/img_5.png")),
    ServiceWidget(
        title: "Cleaning", imagePath: Image.asset("assets/images/img_6.png")),
    ServiceWidget(
        title: "Repairs", imagePath: Image.asset("assets/images/img_7.png")),
    ServiceWidget(
        title: "Re-Organize",
        imagePath: Image.asset("assets/images/img_8.png")),
    ServiceWidget(
        title: "Baby Sitter",
        imagePath: Image.asset("assets/images/img_9.png")),
    ServiceWidget(
        title: "Beauty", imagePath: Image.asset("assets/images/img_10.png")),
    ServiceWidget(
        title: "Re-Organize",
        imagePath: Image.asset("assets/images/img_11.png")),
  ];
  List<String> servicesNames = [
    "Cleaning",
    "Cooking",
    "Cleaning",
    "Repairs",
    "Re-Organize",
    "Baby Sitter",
    "Beauty",
    "Re-Organize"
  ];
}
