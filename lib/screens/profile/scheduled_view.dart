import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/database/order_database.dart';
import 'package:homero/screens/orders/widgets/order_details_view.dart';

import '../../models/order_model.dart';


class ScheduledOrdersView extends StatefulWidget {
  static const String routeName = "ScheduledOrders";

  @override
  State<ScheduledOrdersView> createState() => _ScheduledOrdersViewState();
}

class _ScheduledOrdersViewState extends State<ScheduledOrdersView> {
  List<OrderModel> orders = [];
  initOrders() async {
    orders = await OrderDatabase.getuserScheduledOrders(FirebaseAuth.instance.currentUser?.uid ?? "");
    setState(() {});
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
          "Scheduled Orders",
          style: TextStyle(
            color: Color.fromARGB(255, 84, 84, 84),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 84, 84, 84)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (buildContext, index) {
                      return OrderDetailsView(order: orders[index]);
                    },
                    itemCount: orders.length,
                  ),
                )
              ],
            ),
    );
  }
}
