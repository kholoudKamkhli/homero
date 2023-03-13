import 'package:flutter/material.dart';

import 'ad_widget.dart';
import 'package_widget.dart';
import 'recommended_widget.dart';
import 'service_widget.dart';

class HomeTab extends StatelessWidget {
  List<AdWidget> adWidgest = [AdWidget(), AdWidget(), AdWidget()];

  List<PackageWidget> packages = [PackageWidget(title: "Wedding", color: Color.fromARGB(
      255, 52, 205, 196)),
    PackageWidget(title: "Occasion", color: Color.fromARGB(
        255, 52, 168, 205)),
    PackageWidget(title: "Party", color: Color.fromARGB(
        255, 52, 132, 205)),PackageWidget(title: "Vaccation", color: Color.fromARGB(
        255, 205, 181, 52))
  ];

  List<ServiceWidget> services = [ServiceWidget(title: "Cleaning", imagePath: Image.asset("assets/images/img_6.png")),
    ServiceWidget(title: "Cooking", imagePath: Image.asset("assets/images/img_5.png")),
    ServiceWidget(title: "Cleaning", imagePath: Image.asset("assets/images/img_6.png")),
    ServiceWidget(title: "Repairs", imagePath: Image.asset("assets/images/img_7.png")),
    ServiceWidget(title: "Re-Organize", imagePath: Image.asset("assets/images/img_8.png")),
    ServiceWidget(title: "Baby Sitter", imagePath: Image.asset("assets/images/img_9.png")),
    ServiceWidget(title: "Beauty", imagePath: Image.asset("assets/images/img_10.png")),
    ServiceWidget(title: "Re-Organize", imagePath: Image.asset("assets/images/img_11.png")),
  ];
  List<RecommendedWidget> recommended = [RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service"),
    RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service")
    ,RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service")
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
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
                return adWidgest[index];
              },
              itemCount: adWidgest.length,
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text("Packages", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54
            ),),
          ),
          SizedBox(height: 20,),
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
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text("Services", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54
            ),),
          ),
          SizedBox(height: 20,),
          Container(
            height: 200,
            //margin: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              itemCount: services.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return ServiceWidget(
                  imagePath: services[index].imagePath,
                  title: services[index].title,
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text("Recommended", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54
            ),),
          ),
          SizedBox(height: 20,),
          Container(
            height: 150,
            //margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (buildContext, index) {
                return recommended[index];
              },
              itemCount: recommended.length,
            ),
          ),
        ],
      ),
    );
  }
}
