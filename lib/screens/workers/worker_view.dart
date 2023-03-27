import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:homero/controllers/payment/payment_view_model.dart';
import 'package:homero/models/service_model.dart';
import 'package:homero/models/worker_model.dart';
import 'package:homero/screens/payment/payment_view.dart';
import 'package:homero/screens/workers/worker_widget.dart';
import 'package:http/http.dart' as http;

import '../../database/worker_database.dart';
import '../service_details/service_details_view.dart';

class WorkerView extends StatefulWidget {
  static const String routeName = "Worker";

  @override
  State<WorkerView> createState() => _WorkerViewState();
}

class _WorkerViewState extends State<WorkerView> {
  static bool buttonClicked = false;
  List<WorkerModel>workers = [];
  Future<List<WorkerModel>> initWorkers(String serviceName) async {
    List<WorkerModel> workers = await WorkerDatabase.getWorkers(serviceName);
    return workers;
  }
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
    SubServiceModel service = ModalRoute.of(context)!.settings.arguments as SubServiceModel;
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
          //
          Expanded(child: FutureBuilder<List<WorkerModel>>(
            future: initWorkers(service.title??""),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                workers = (snapshot.data as List<WorkerModel>?) ?? [];
                print(service.title??"");
                print(workers.length);
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return WorkerWidget(
                      worker: workers[index],
                      changecolor: onClickCallBack,
                    );
                  },
                  itemCount: workers.length,
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),),
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
                   Navigator.pushNamed(context, ServiceDetailsView.routeName,arguments: service);
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
  }

}
