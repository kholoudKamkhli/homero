import 'package:flutter/material.dart';
import 'package:homero/screens/home_tab_screen/widgets/service_widget.dart';

import '../../services/services_view.dart';

class MoreServiceWidget extends ServiceWidget {
  MoreServiceWidget({required super.service, required super.title, required super.imagePath});



  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ServicesView.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(0, 206, 199, 199)
          ),
          width: 90,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.add,color: Color.fromARGB(0, 206, 199, 199)
                    ,size:12 ,),
                  SizedBox(width: 4,),
                  Text("More",style: TextStyle(
                      color: Color.fromARGB(0, 206, 199, 199),
                    fontSize:12 ,
                    fontWeight: FontWeight.w400,
                  ),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
