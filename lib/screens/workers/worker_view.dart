import 'package:flutter/material.dart';
import 'package:homero/screens/workers/worker_widget.dart';

class WorkerView extends StatefulWidget {
  static const String routeName = "Worker";

  @override
  State<WorkerView> createState() => _WorkerViewState();
}

class _WorkerViewState extends State<WorkerView> {
  static bool buttonClicked = false;
  List<WorkerWidget> workers = [
    WorkerWidget(
      image: Image.asset(
        "assets/images/img_35.png",
        width: 82,
        height: 82,
      ),
      name: "Aly Said",
      jobTitle: "Cleaning Expert",
      numOfDoneTasks: 4,
      numOfRatings: 12,
      rating: 4,
      changecolor:(){},
    ),
    WorkerWidget(
      image: Image.asset("assets/images/img_36.png", width: 82, height: 82),
      name: "Lily Khalaf",
      jobTitle: "Cleaning Expert",
      numOfDoneTasks: 4,
      numOfRatings: 12,
      rating: 3,
      changecolor: (){
        buttonClicked = !buttonClicked;
        print("is Clicked $buttonClicked");
      },
    ),
    //WorkerWidget(image: Image.asset("assets/images/img_35.png"), name: "Aly Said", jobTitle: "Cleaning Expert", numOfDoneTasks: 4, numOfRatings: 12, rating: 4),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  static changeColor(){
    buttonClicked = !buttonClicked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text(
          "Workers",
          style: TextStyle(
            color: Color.fromARGB(255, 84, 84, 84),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 84, 84, 84)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) {
                return  getWorkers()[index];
              },
              itemCount: getWorkers().length,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 127,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: buttonClicked == false
                  ? Colors.transparent
                  : Color.fromARGB(255, 84, 84, 84),
            ),
            child: InkWell(
              // onTap: () {
              //   buttonClicked = !buttonClicked;
              //   setState(() {});
              // },
              onTap: (){
                if(buttonClicked == true){

                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: buttonClicked == false
                      ? Color.fromARGB(255, 84, 84, 84)
                      : Color.fromARGB(255, 52, 205, 196),
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void onClickCallBack(bool isSelected){
    if(isSelected == true){
      buttonClicked = true;
    }
    else{
      buttonClicked = false;
    }
    setState(() {

    });
    print("HI");
    print(buttonClicked);
  }
  List<WorkerWidget> getWorkers(){
    return [
      WorkerWidget(
        image: Image.asset(
          "assets/images/img_35.png",
          width: 82,
          height: 82,
        ),
        name: "Aly Said",
        jobTitle: "Cleaning Expert",
        numOfDoneTasks: 4,
        numOfRatings: 12,
        rating: 4,
        changecolor:onClickCallBack,
      ),
      WorkerWidget(
        image: Image.asset("assets/images/img_36.png", width: 82, height: 82),
        name: "Lily Khalaf",
        jobTitle: "Cleaning Expert",
        numOfDoneTasks: 4,
        numOfRatings: 12,
        rating: 3,
        changecolor:onClickCallBack,
      ),
      //WorkerWidget(image: Image.asset("assets/images/img_35.png"), name: "Aly Said", jobTitle: "Cleaning Expert", numOfDoneTasks: 4, numOfRatings: 12, rating: 4),
    ];
  }
}
