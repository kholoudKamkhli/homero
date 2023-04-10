import 'package:flutter/material.dart';
import 'package:homero/screens/home_tab_screen/widgets/sub_service_widget.dart';
import 'package:homero/screens/services/service_tab_widget.dart';

import '../../database/service_database.dart';
import '../../models/service_model.dart';
import '../home_tab_screen/widgets/service_widget.dart';

class ServicesView extends StatefulWidget {
  static const String routeName = "ServicesView";

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  List<ServiceModel> services = [];
  List<SubServiceModel> subServices = [];
  String? searchService;
  int selectedIndex = 0;
  List<SubServiceModel>searchServices = [];

  initSubService() async {
    subServices = await ServiceDatabase.getServiceSubServices(
        services[selectedIndex].id ?? "");
  }

  initServices() async {
    services = await ServiceDatabase.getMainServices();
    Future.delayed(Duration(seconds: 40));
    subServices = await ServiceDatabase.getServiceSubServices(
        services[selectedIndex].id ?? "");
    print(services);
    setState(() {
      print("here inside init state id is ${services[selectedIndex].id}");
    });
  }

  @override
  void initState() {
    super.initState();
    //String? serviceId = ModalRoute.of(context)?.settings.arguments as String?;
    //print("here is service ID $serviceId");
    initServices();
  }


  @override
  Widget build(BuildContext context) {
    //var serviceArgId= ModalRoute.of(context)?.settings?.arguments??"" as String;
    //var sss = ServiceDatabase.getServiceById(serviceArgId.toString());
    //var initIndex = services.indexOf(sss);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
          style: TextStyle(
            color: Color.fromARGB(255, 84, 84, 84),
          ),
        ),
        leading: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: TextFormField(
                  onChanged: (value)async{
                    searchService = value;
                    searchServices = await ServiceDatabase.getAllSubServices(value);
                    setState(() {
                    print("onChanged value $searchService");
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "What Services Are You Looking For?",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ),
            ),
          ),
          //ServiceTabsWidget(),
          searchService != null
              ? SizedBox(
                  height: 0,
                )
              : SizedBox(
                  height: 10,
                ),
          searchService != null
              ? Container()
              : SizedBox(
                  height: 60,
                  child: DefaultTabController(
                    initialIndex: 1,
                    length: services.length,
                    child: TabBar(
                      onTap: (index) async {
                        selectedIndex = index;
                        subServices = await ServiceDatabase.getServiceSubServices(
                            services[index].id ?? "");
                        setState(() {
                        });
                      },
                      tabs: services
                          .map((e) => ServiceTabWidget(
                                name: e.title ?? "",
                                isSelected: selectedIndex == services.indexOf(e)
                                    ? true
                                    : false,
                              ))
                          .toList(),
                      isScrollable: true,
                      indicatorColor: Colors.transparent,

                    ),
                  ),
                ),

          searchService != null
              ? Expanded(
            child: searchServices.length == 0
                ? Center(
              child: Text("No matched results"),
            )
                : GridView.builder(
              itemBuilder: (buildContext, index) {
                return SubServiceWidget(subservice: searchServices[index]);
              },
              itemCount: searchServices.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
            ),
          )
              : Expanded(
                  child: subServices.length == 0
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemBuilder: (buildContext, index) {
                            return SubServiceWidget(
                                subservice: subServices[index]);
                          },
                          itemCount: subServices.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                        ),
                )
        ],
      ),
    );
  }
}
