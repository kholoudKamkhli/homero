import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/database/order_database.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/orders/widgets/oder_tab_widget.dart';
import 'package:homero/screens/orders/widgets/order_details_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_models/order_view_model.dart';
import 'widgets/order_widget.dart';

class OrdersView extends StatefulWidget {
  static const String routeName = "Order view";

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  List<OrderModel> orders = [];
  OrderViewModel viewModel = OrderViewModel();
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    viewModel.initOrders(0);
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
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomeScreenView.routeName),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider<OrderViewModel>(
        create: (_)=>viewModel,
        child: Column(
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
                      onTap: (index) async {
                        selectedIndex = index;
                        if (index == 0) {
                          orders = viewModel.initOrders(0);
                        } else if (index == 1) {
                          orders =viewModel.initOrders(1);
                        } else {
                          orders = viewModel.initOrders(2);
                        }
                        setState(() {
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
            BlocBuilder<OrderViewModel,OrderState>(
                builder: (context,state){
                  if(state is LoadingState){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if(state is LoadedState){
                    orders = state.orders;
                    return Expanded(
                      child: ListView.builder(
                              itemBuilder: (buildContext, index) {
                                return OrderDetailsView(order: orders[index]);
                              },
                              itemCount:orders.length ?? 0,
                            ),
                    );
                  }
                  else if(state is ErrorState){
                    return Center(child: Text(state.errorMessage),);
                  }
                   else {
                    return CircularProgressIndicator();
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}
