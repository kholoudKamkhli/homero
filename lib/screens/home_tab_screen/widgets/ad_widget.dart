import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/ad_model.dart';

class AdWidget extends StatelessWidget {
  AdModel ad;
  AdWidget({required this.ad});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 190,
      width: 380,
      child:Stack(
        children: [
          Image.network(ad.backgroundImagePath,fit: BoxFit.fill,),
          Row(
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
                              ad.title,
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
                  child: Image.network(ad.imagePath,width: MediaQuery.of(context).size.width*0.5,)),
            ],
          ),

        ],
      ) ,
    );
  }
}
