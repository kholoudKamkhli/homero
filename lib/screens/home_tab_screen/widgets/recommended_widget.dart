import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RecommendedWidget extends StatelessWidget {
  Image path;
  String name;
  String latestReview;
  String username;
  RecommendedWidget({required this.path,required this.username,required this.name,required this.latestReview});

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
                  child: path),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                      child: Text(name,style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        //color: Colors.black54
                      ),),
                    ),
                    const SizedBox(width: 10,),
                    Row(
                      children: [
                        IconButton(
                          icon: const ImageIcon(
                            AssetImage("assets/images/img_1.png"),
                            color: Color.fromARGB(255, 52, 205, 196),
                          ),
                          onPressed: () {
                            // do something
                          },
                        ),
                        Text(username,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12),)
                      ],
                    ),
                    //Text("Latest Reviews",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),)
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Latest Reviews",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(latestReview,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black54),),
                ),
                Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                        child: Text("Rate",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                              color: Color.fromARGB(255, 52, 205, 196)
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 52, 205, 196),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text("Order Now",style: TextStyle(
                        color: Colors.
                          white
                      ),),
                    ),
                  )

                ],)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
