import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/order_model.dart';

class OrderDetailsView extends StatelessWidget {
  OrderModel order;
  OrderDetailsView({required this.order});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        height:149 ,
        width: 370,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                  height: 128,
                  child: Image.asset("assets/images/img_12.png")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.serviceName,style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 84, 84, 84),
                    //color: Colors.black54
                  ),),
                  const SizedBox(height: 10,),
                  Text(
                    "By ${order.workerName}",style: TextStyle(
                    color: Color.fromARGB(255, 84, 84, 84),
                    fontWeight:FontWeight.w400 ,
                    fontSize:12 ,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children:  [
                      Text(
                        "Time ",style: TextStyle(
                        color: Color.fromARGB(255, 84, 84, 84),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                      Text(
                        "${DateFormat.Hm().format(order.date)} AM ",style: TextStyle(
                        color: Color.fromARGB(255, 126, 127, 131),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children:  [
                      Text(
                        "Date ",style: TextStyle(
                        color: Color.fromARGB(255, 84, 84, 84),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                      Text(
                        "${DateFormat.yMMMEd().format(order.date)}",style: TextStyle(
                        color: Color.fromARGB(255, 126, 127, 131),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children:  [
                      Icon(Icons.location_on_outlined,size: 15,color: Color.fromARGB(
                          255, 84, 84, 84),),
                      Text("${order.location.substring(0,40)}...",style: TextStyle(
                        
                        color:Color.fromARGB(
                            255, 126, 127, 131),
                      ),),
                    ],
                  )
                ],

              ),

            ),
          ],
        ),
      ),
    );
  }
}
