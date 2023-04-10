import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:homero/database/order_database.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/models/service_model.dart';
import 'package:homero/screens/payment/payment_view.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controllers/user_location_controller.dart';
import '../workers/worker_view.dart';

class ServiceDetailsView extends StatefulWidget {
  static const String routeName = "serviceDetails";

  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  var nameCont = TextEditingController();

  var numCont = TextEditingController();

  var locationCont = TextEditingController();
  var formKey = GlobalKey<FormState>();

  UserLocationController locationController = UserLocationController();
  var dateCont = TextEditingController();
  var selectedRoomArea;
  var selectedRoom;
  var selectedSchedule;

  var completeNum;
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRoomArea = areas[0];
    selectedRoom = rooms[0];
    selectedSchedule = schedules[0];
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final service = args['service'] as SubServiceModel;
    final workerName = args['workerName'] as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text(
          "Deep cleaning service",
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
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 327,
                    height: 70,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black45)),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            "Full name",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: nameCont,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter valid name";
                                } else {
                                  return null;
                                }
                              },
                              cursorHeight: 0,
                              cursorWidth: 0,
                              decoration:
                              const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, right: 5),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    width: 327,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color.fromARGB(255, 126, 127,
                          131)),
                    ),
                    child: IntlPhoneField(
                      controller: numCont,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter valid name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        border: InputBorder.none,
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        completeNum = phone.completeNumber;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Enter location",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Color.fromARGB(255, 126, 127, 131),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (locationCont.text != null &&
                              locationCont.text != "") {
                            // user!.address = locationCont.text;
                            // UserDatabase.editUser(user!);
                          }
                        },


                        controller: locationCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid location";
                          } else {
                            return null;
                          }
                        },
                        //focusNode: locationFocus,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var first = await getUserLocation();
                              locationCont.text =
                                  first?.addressLine?.toString() ?? "";
                            },
                            icon: Icon(
                              Icons.gps_fixed,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                          focusColor: Colors.transparent,
                          hintText: "location",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          filled: true,
                          enabled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "Enter Date And Time",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Color.fromARGB(255, 126, 127, 131),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                      height: 70,
                      child: TextFormField(
                        controller: dateCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid location";
                          } else {
                            return null;
                          }
                        },
                        //focusNode: locationFocus,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () {
                              showTaskDatePicker();
                            },
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                          focusColor: Colors.transparent,
                          hintText: "Date",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          filled: true,
                          enabled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              "Area",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Color.fromARGB(255, 126, 127, 131),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.only(left: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton(
                                underline: SizedBox(),
                                value: selectedRoomArea,
                                items: areas
                                    .map((room) =>
                                    DropdownMenuItem<String>(
                                        value: room,
                                        child: Row(
                                          children: [
                                            Text(room),
                                          ],
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  } else {
                                    setState(() {
                                      selectedRoomArea = value;
                                    });
                                  }
                                }),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              "Rooms",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Color.fromARGB(255, 126, 127, 131),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton(
                                underline: SizedBox(),
                                value: selectedRoom,
                                items: rooms
                                    .map((room) =>
                                    DropdownMenuItem<int>(
                                        value: room,
                                        child: Row(
                                          children: [
                                            Text("$room"),
                                          ],
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  } else {
                                    setState(() {
                                      selectedRoom = value;
                                    });
                                  }
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    height: 1,
                    color: Color.fromARGB(255, 217, 217, 217),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            "Schedule Service",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Color.fromARGB(255, 126, 127, 131),
                            ),
                          ),
                        ),
                        Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: Color.fromARGB(255, 52, 205, 196),
                          activeTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.black12,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 270,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSwitched ? Colors.white : Color.fromARGB(
                            255, 234, 234, 234)),
                    child: DropdownButton(
                        underline: SizedBox(),
                        value: selectedSchedule,
                        items: schedules
                            .map((schedule) =>
                            DropdownMenuItem<String>(
                                value: schedule,
                                child: Row(
                                  children: [
                                    Text(schedule),
                                  ],
                                )))
                            .toList(),
                        onChanged: isSwitched ? (value) {
                          if (value == null) {
                            return;
                          } else {
                            setState(() {
                              selectedSchedule = value;
                            });
                          }
                        } : null),
                  ),

                ],
              ),
            ),),

            Container(
              alignment: Alignment.center,
              height: 127,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 84, 84, 84),
              ),
              child: InkWell(
                // onTap: () {
                //   buttonClicked = !buttonClicked;
                //   setState(() {});
                // },
                onTap: () async{
                  if (formKey.currentState!.validate()) {
                    print(workerName);
                    print(service.cost);
                    print(service.id);
                    OrderModel order = OrderModel(
                      cost: service.cost,
                      uId: FirebaseAuth.instance.currentUser!.uid,
                        serviceName:service.title, location: locationCont.text,
                        date: selectedDate,
                        area: selectedRoomArea,
                        fullName: nameCont.text,
                        isFinished: false,
                        isScheduled: isSwitched,
                        mobileNum: completeNum,
                        numOfRoom: selectedRoom,
                        workerName:workerName,
                        scheduling: selectedSchedule);
                    //await OrderDatabase.addOrder(order);
                    Navigator.pushNamed(
                        context, PaymentView.routeName, arguments: order);
                  }
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color.fromARGB(255, 52, 205, 196),
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
      ),
    );
  }

  Future<Address?> getUserLocation() async {
    locationController.requestService();
    locationController.requestPermession();
    bool isServiceEnabled = await locationController.requestService();
    bool isPermessionGranted = await locationController.requestPermession();
    if (isServiceEnabled && isPermessionGranted) {
      var locationData = await locationController.getLocation();
      final coordinates =
      new Coordinates(locationData?.latitude, locationData?.longitude);
      var address =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = address.first;
      return first;
    }
  }

  var selectedDate = DateTime.now();

  void showTaskDatePicker() async {
    var userSelecteDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelecteDate == null) {
      return;
    } else {
      setState(() {
        dateCont.text = DateFormat.yMMMEd().format(selectedDate);
      });
    }
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  List<String> areas = ["80-120 sqm", "120-200 sqm", "200-400 sqm"];
  List<int> rooms = [1, 2, 3, 4, 5, 6, 7, 8];
  List<String>schedules = ["Every Week", "Every Month", "Every Year"];
}
