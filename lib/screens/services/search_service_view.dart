import 'package:flutter/material.dart';

class SearchServiceView extends StatelessWidget {
  static const String routeName = "SearchScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
          style: TextStyle(
            color: Color.fromARGB(255, 84, 84, 84),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 84, 84, 84)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ],
      ),
    );  }
}
