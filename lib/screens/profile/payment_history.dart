import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../database/order_database.dart';
import '../../models/order_model.dart';

class PaymentHistory extends StatefulWidget {
  static const String routeName = "payment history";

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  var orders;

  initOrders() async {
    orders = await OrderDatabase.getuserAllOrders(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {});
    print(orders.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment History",
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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              child: FutureBuilder<List<OrderModel>>(
                future: OrderDatabase.getuserAllOrders(
                    FirebaseAuth.instance.currentUser!.uid),
                // a previously-obtained Future<String> or null
                builder: (BuildContext context, snapshot) {
                  List<OrderModel>? subServices;
                  if (snapshot.hasData) {
                    subServices = snapshot.data;
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Couldn't get Payments"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (buildContext, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black12,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width:MediaQuery.of(context).size.width*0.5,
                                    child: Text(
                                      "Service Ordered",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    orders[index].serviceName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  SizedBox(
                                    width:MediaQuery.of(context).size.width*0.5,
                                    child: Text(
                                      "Amount Paid",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    orders[index].cost.toString(),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  SizedBox(
                                    width:MediaQuery.of(context).size.width*0.5,
                                    child: Text(
                                      "Order status",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    orders[index].isFinished?"Finished":"Scheduled",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: orders!.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
