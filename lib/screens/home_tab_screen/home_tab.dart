import 'package:flutter/material.dart';
import 'package:homero/database/ad_database.dart';
import 'package:homero/database/recommendation_database.dart';
import 'package:homero/database/service_database.dart';
import 'package:homero/models/ad_model.dart';
import 'package:homero/models/reccomendation_model.dart';
import 'package:homero/models/service_model.dart';
import 'package:homero/screens/home_tab_screen/widgets/more_service_widget.dart';

import '../../models/worker_model.dart';
import 'widgets/ad_widget.dart';
import 'widgets/package_widget.dart';
import 'widgets/recommended_widget.dart';
import 'widgets/service_widget.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<ServiceModel>services=[];

  List<AdModel> ads = [];
  List<RecommendationModel> recommends = [];
  List<ServiceWidget> servicesWidgets = [];

  List<PackageWidget> packages = [PackageWidget(title: "Wedding", color: const Color.fromARGB(
      255, 52, 205, 196)),
    PackageWidget(title: "Occasion", color: const Color.fromARGB(
        255, 52, 168, 205)),
    PackageWidget(title: "Party", color: const Color.fromARGB(
        255, 52, 132, 205)),PackageWidget(title: "Vaccation", color: const Color.fromARGB(
        255, 205, 181, 52))
  ];

  // List<RecommendedWidget> recommended = [RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service"),
  //   RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service")
  //   ,RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service")
  // ];
  initServices()async{
    services = await ServiceDatabase.getMainServices();
    ads = await AdDatabase.getAds();
    recommends = await RecommendationDatabase.getRecommends();
    // WorkerModel worker = await RecommendationDatabase.getRecommendedWorker("XijqsEXSqx7GX8gBMwQJ");
    // SubServiceModel subb = await RecommendationDatabase.getRecommendedSubService("XijqsEXSqx7GX8gBMwQJ");
    setState(() {

    });

  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
      initServices();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          Container(
            height: 200,
            //margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (buildContext, index) {
                return AdWidget(ad: ads[index]);
              },
              itemCount: ads.length,
            ),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.only(left:8.0),
            child: Text("Packages", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54
            ),),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 40,
            //margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (buildContext, index) {
                return packages[index];
              },
              itemCount: packages.length,
            ),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.only(left:8.0),
            child: Text("Services", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54
            ),),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 200,
            //margin: EdgeInsets.symmetric(horizontal: 10),
            //child: ListView(
             // children:[
                child: GridView.builder(
                  itemCount: services.length<8?services.length+1:8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return services.length!=0?index==8||index==services.length?MoreServiceWidget(service: services[0], title: services[0].title, imagePath: services[0].imageUrl):ServiceWidget(
                      service: services[index],
                      imagePath: services[index].imageUrl,
                      title: services[index].title,
                    ):Center(child: CircularProgressIndicator(),);
                  },
                ),
  //  ]
            ),

          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.only(left:8.0),
            child: Text("Recommended", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54
            ),),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 150,
            //margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (buildContext, index) {
                return RecommendedWidget(recommendationModel: recommends[index]);
              },
              itemCount: recommends.length,
            ),
          ),
        ],
      ),
    );
  }
}
