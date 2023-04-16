
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/controllers/payment/payment_connector.dart';
import 'package:homero/controllers/payment/payment_view_model.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/map/map_screen.dart';
import 'package:intl/intl.dart';

import '../../controllers/base_classes/base.dart';
import '../../database/user_database.dart';

class PaymentView extends StatefulWidget {
  static const String routeName = "payment";

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends BaseView<PaymentViewModel, PaymentView>
    implements PaymentConnector {
  var order;
  MyUser? user;

  //ServiceWidget service = ServiceWidget(title: "Deep cleaning service", imagePath: "gs://homear-intern.appspot.com/app_images/Group 34983.png");
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
    viewModel = initViewModel();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:  Text(
          "Payment",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 84, 84, 84)),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Services",
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 127, 131),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    order.serviceName,
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 127, 131),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Text(
                    order.location,
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 127, 131),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Text(
                    "${DateFormat.yMMMEd().format(order.date)}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 127, 131),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Text(
                    "${order.numOfRoom} Rooms",
                    style: TextStyle(
                      color: Color.fromARGB(255, 126, 127, 131),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: order.isScheduled
                      ? Text(
                          "1 service-${order.scheduling}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 127, 131),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Text(
                          "1 service-non scheduled",
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 127, 131),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Container(
                    height: 1,
                    width: 318,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 217, 217, 217)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Row(
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          "1 Service",
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 127, 131),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Row(
                    children: [
                      Text(
                        "Payment",
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          "${order.cost} LE",
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 127, 131),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Container(
                    height: 1,
                    width: 318,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 217, 217, 217)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30.0),
                  child: Row(
                    children: [
                      Text(
                        "Total Payment",
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          "${order.cost} LE",
                          style: TextStyle(
                            color: Color.fromARGB(255, 126, 127, 131),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  height: 127,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 84, 84, 84),
                  ),
                  child: InkWell(
                    // onTap: () {
                    //   buttonClicked = !buttonClicked;
                    //   setState(() {});
                    // },
                    onTap: () async {
                      await viewModel.makePayment(order.cost.toString(), order);
                      //Navigator.pushNamed(context, HomeScreenView.routeName);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
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
    );
  }

  Future<void> initUser() async {
    print(FirebaseAuth.instance.currentUser!.uid);
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
  }

  @override
  PaymentViewModel initViewModel() {
    return PaymentViewModel();
  }

  @override
  goToHome() {
    Navigator.pushNamed(context, MapScreen.routeName, arguments: order);
  }
}
