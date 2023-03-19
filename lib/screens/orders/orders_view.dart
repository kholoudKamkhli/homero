import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/screens/orders/widgets/order_details_view.dart';
import 'package:homero/screens/orders/widgets/orders_tab_widget.dart';

import 'widgets/order_widget.dart';

class OrdersView extends StatelessWidget {
  List<OrderWidget>orders = [OrderWidget(name: "All"),OrderWidget(name: "Scheduled"),OrderWidget(name: "Finished"),];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          OrderTabsWidget(orders: orders),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(itemBuilder: (buildContext,index){
              return OrderDetailsView(name: "Cooking", image: Image.asset("assets/images/img_12.png"), username: "Sara Ali");
            },itemCount: 1,),
          )
        ],
      ),
    );
  }
}
