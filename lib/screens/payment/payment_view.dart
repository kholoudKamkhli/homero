import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/map/map_screen.dart';
import 'package:intl/intl.dart';

import '../../controllers/database/user_database.dart';
import '../../controllers/view_models/pay_view_model.dart';
class PaymentView extends StatefulWidget {
  static const String routeName = "payment";

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView>
     {
  var order;
  MyUser? user;
  PayViewModel payViewModel = PayViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    return BlocProvider<PayViewModel>(
      create: (_)=>payViewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title:  Text(
            "Payment",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                ),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: user == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : BlocConsumer<PayViewModel,PaymentState>(builder: (context,state){
              if(state is ErrorPayment){
                return Center(child: Text(state.errorMessage),);
              }
              else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Services",
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        order.serviceName,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30.0),
                      child: Text(
                        order.location,
                        style: const TextStyle(
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
                        style: const TextStyle(
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
                        style: const TextStyle(
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
                        style: const TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                          : const Text(
                        "1 service-non scheduled",
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 127, 131),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30.0),
                      child: Container(
                        height: 1,
                        width: 318,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 217, 217, 217)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30.0),
                      child: Row(
                        children: [
                          const Text(
                            "Amount",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          const Padding(
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
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30.0),
                      child: Row(
                        children: [
                          const Text(
                            "Payment",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              "${order.cost} LE",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 126, 127, 131),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30.0),
                      child: Container(
                        height: 1,
                        width: 318,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 217, 217, 217)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30.0),
                      child: Row(
                        children: [
                          const Text(
                            "Total Payment",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(
                              "${order.cost} LE",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 126, 127, 131),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    BlocProvider<PayViewModel>(
                      create: (_)=>payViewModel,
                      child: Container(
                        alignment: Alignment.center,
                        height: 127,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 84, 84, 84),
                        ),
                        child: InkWell(

                          onTap: () async {
                            await payViewModel.makePayment(order.cost.toString(), order);

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 58,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: const Color.fromARGB(255, 52, 205, 196),
                            ),
                            child: const Text(
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
                    ),
                  ],
                );
              }
        }, listener: (context,state){
              if(state is DonePayment){
                Navigator.pushNamed(context, MapScreen.routeName, arguments: order);
              }
        })

      ),
    );
  }
  Future<void> initUser() async {
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
  }

}
