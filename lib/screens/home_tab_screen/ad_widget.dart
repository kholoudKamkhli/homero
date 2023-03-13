import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 380,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF37D9CF),
            Color(0xFF2CC7BE),
            Color(0xFF27BEB5),
            Color(0xFF1CA39A),
          ],
          stops: [
            0.1794,
            0.3741,
            0.6419,
            0.8471,
          ],
          transform: GradientRotation(192.89 * 3.14 / 180),
        ),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                margin: EdgeInsets.only(
                  bottom: 28,
                  left: 28,
                ),
                child: Text(
                  "20% off on cleaning dishes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 30,
                ),
                width:84,
                height:25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child:Container(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Text("Order now",style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),),
                ) ,
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/img_4.png",width: MediaQuery.of(context).size.width*0.5,))
        ],
      ),
    );
  }
}
