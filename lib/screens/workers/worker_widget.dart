import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WorkerWidget extends StatefulWidget {
  Image image;
  String name;
  String jobTitle;
  int numOfRatings;
  int rating;
  int numOfDoneTasks;
  Function changecolor;

  WorkerWidget(
      {required this.image,
      required this.name,
      required this.jobTitle,
      required this.numOfDoneTasks,
      required this.numOfRatings,
      required this.rating,
      required this.changecolor});

  @override
  State<WorkerWidget> createState() => _WorkerWidgetState();
}

class _WorkerWidgetState extends State<WorkerWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        isSelected = !isSelected;
        print(isSelected);
        widget.changecolor(isSelected);
        setState(() {

        });
     },
     //  onTap: (){
     //    widget.changecolor();
     //  },
      child: Card(
        color: isSelected==false?Colors.white:Color.fromARGB(255, 52, 205, 196),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 100,
          width: 370,
          child: Row(
            children: [
              Container(
                width: 62,
                height: 62,
                child: widget.image,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 9, top: 6, bottom: 2),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 40, 42, 46)),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                        child: Text(
                          widget.jobTitle,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 126, 127, 131)
                              //color: Colors.black54
                              ),
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        "${widget.numOfRatings} Ratings",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color.fromARGB(255, 126, 127, 131)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
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
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(widget.numOfRatings);
                              },
                            ),
                          ),
                          SizedBox(width:50),
                          Icon(Icons.done,color: Color.fromARGB(255, 126, 127, 131,),size: 14,),
                          SizedBox(width: 3,),
                          Text("${widget.numOfDoneTasks} Cleaning Tasks",style: TextStyle(
                            color: Color.fromARGB(255, 126, 127, 131,),
                            fontWeight: FontWeight.w500,
                            fontSize:12 ,
                          ),)

                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}