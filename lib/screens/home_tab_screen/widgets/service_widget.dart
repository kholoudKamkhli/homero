import 'package:flutter/material.dart';
import 'package:homero/screens/home_tab_screen/widgets/service_elements.dart';
import 'package:homero/screens/service_details/service_details_view.dart';

import '../../../models/service_model.dart';
import '../../services/services_view.dart';
import '../../workers/worker_view.dart';

class ServiceWidget extends StatelessWidget {
  ServiceModel service;
  String imagePath;
  String title;

    ServiceWidget({required this.service,required this.title,required this.imagePath});
  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ServicesView.routeName,arguments: service.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: 90,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image.asset(
              //   imagePath,
              //   width: MediaQuery.of(context).size.width * 0.7,
              //   height: MediaQuery.of(context).size.height * 0.7,
              // ),
              Container(
                height: 34,
                width: 34,
                child: Image.network(imagePath),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
