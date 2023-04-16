import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/database/order_database.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/orders/widgets/oder_tab_widget.dart';
import 'package:homero/screens/orders/widgets/order_details_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/order_widget.dart';

class OrdersView extends StatefulWidget {
  static const String routeName = "Order view";
  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  // List<OrderWidget> ordersType = [
  //   OrderWidget(name: "All"),
  //   OrderWidget(name: "Scheduled"),
  //   OrderWidget(name: "Finished"),
  // ];

  List<OrderModel> orders = [];

  int selectedIndex = 0;

  initOrders() async {
    orders = await OrderDatabase.getuserAllOrders(
        FirebaseAuth.instance.currentUser!.uid);
    setState(() {

    });
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
    List<OrderWidget> ordersType = [
      OrderWidget(name: AppLocalizations.of(context)!.all),
      OrderWidget(name: AppLocalizations.of(context)!.schedule),
      OrderWidget(name: AppLocalizations.of(context)!.finished),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.orders,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              ),
          onPressed: () => Navigator.pushReplacementNamed(context, HomeScreenView.routeName),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: DefaultTabController(
              length: ordersType.length,
              child: Column(
                children: [
                  TabBar(
                    onTap: (index) async{
                        selectedIndex = index;
                        if(index==0){
                          orders = await OrderDatabase.getuserAllOrders(
                              FirebaseAuth.instance.currentUser!.uid);
                        }
                        else if(index == 1){
                          orders = await OrderDatabase.getuserScheduledOrders(FirebaseAuth.instance.currentUser!.uid);
                        }
                        else{
                          orders = await OrderDatabase.getuserFinishedOrders(FirebaseAuth.instance.currentUser!.uid);
                        }
                        setState(() {
                         print("length is ${orders.length}");
                        });

                    },
                    tabs: ordersType
                        .map((e) => OrderTabWidget(
                              name: e.name ?? "",
                              isSelected: selectedIndex == ordersType.indexOf(e)
                                  ? true
                                  : false,
                            ))
                        .toList(),
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (buildContext, index) {
                return OrderDetailsView(order: orders![index]);
              },
              itemCount: orders?.length ?? 0,
            ),
          )
        ],
      ),
    );
  }
}
