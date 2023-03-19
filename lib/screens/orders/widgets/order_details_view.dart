import 'package:flutter/material.dart';

class OrderDetailsView extends StatelessWidget {
  Image image;
  String name;
  String username;
  OrderDetailsView({required this.name,required this.image,required this.username});
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
                  child: image),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 84, 84, 84),
                    //color: Colors.black54
                  ),),
                  const SizedBox(height: 10,),
                  Text(
                    "By ${username}",style: TextStyle(
                    color: Color.fromARGB(255, 84, 84, 84),
                    fontWeight:FontWeight.w400 ,
                    fontSize:12 ,
                  ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: const [
                      Text(
                        "Time ",style: TextStyle(
                        color: Color.fromARGB(255, 84, 84, 84),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                      Text(
                        "10:00 AM ",style: TextStyle(
                        color: Color.fromARGB(255, 126, 127, 131),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: const [
                      Text(
                        "Date ",style: TextStyle(
                        color: Color.fromARGB(255, 84, 84, 84),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                      Text(
                        " 23 Jan 2023",style: TextStyle(
                        color: Color.fromARGB(255, 126, 127, 131),
                        fontWeight:FontWeight.w400 ,
                        fontSize:12 ,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: const [
                      Icon(Icons.location_on_outlined,size: 15,color: Color.fromARGB(
                          255, 84, 84, 84),),
                      Text("Andria Russell.414- 73354",style: TextStyle(
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
