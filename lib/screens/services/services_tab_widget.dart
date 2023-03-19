import 'package:flutter/material.dart';
import 'package:homero/screens/services/service_tab_widget.dart';

import '../home_tab_screen/service_widget.dart';

class ServiceTabsWidget extends StatefulWidget {
  List<ServiceWidget> services;

  ServiceTabsWidget({required this.services});

  @override
  State<ServiceTabsWidget> createState() => _ServiceTabsWidgetState();
}

class _ServiceTabsWidgetState extends State<ServiceTabsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: widget.services.length,
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              tabs: widget.services
                  .map((e) => ServiceTabWidget(
                        name: e.title ?? "",
                        isSelected: selectedIndex == widget.services.indexOf(e)
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
    );
  }
}
