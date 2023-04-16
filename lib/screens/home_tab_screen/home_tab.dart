import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:homero/database/ad_database.dart';
import 'package:homero/database/recommendation_database.dart';
import 'package:homero/database/service_database.dart';
import 'package:homero/models/ad_model.dart';
import 'package:homero/models/reccomendation_model.dart';
import 'package:homero/models/service_model.dart';
import 'package:homero/screens/home_tab_screen/widgets/more_service_widget.dart';
import 'package:homero/screens/services/selected_service_view.dart';
import 'package:searchfield/searchfield.dart';
import 'widgets/ad_widget.dart';
import 'widgets/package_widget.dart';
import 'widgets/recommended_widget.dart';
import 'widgets/service_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<ServiceModel> services = [];
  List<String> servicesNames = [];
  List<AdModel> ads = [];
  List<RecommendationModel> recommends = [];
  List<ServiceWidget> servicesWidgets = [];
  var searchCont = TextEditingController();

  List<PackageWidget> packages = [
    PackageWidget(
        title: "Wedding", color: const Color.fromARGB(255, 52, 205, 196)),
    PackageWidget(
        title: "Occasion", color: const Color.fromARGB(255, 52, 168, 205)),
    PackageWidget(
        title: "Party", color: const Color.fromARGB(255, 52, 132, 205)),
    PackageWidget(
        title: "Vaccation", color: const Color.fromARGB(255, 205, 181, 52))
  ];

  // List<RecommendedWidget> recommended = [RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service"),
  //   RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service")
  //   ,RecommendedWidget(path:Image.asset("assets/images/img_12.png"), username: "Sara", name: "HomeCleaning", latestReview: "Very good service")
  // ];
  initServices() async {
    services = await ServiceDatabase.getMainServices();
    ads = await AdDatabase.getAds();
    recommends = await RecommendationDatabase.getRecommends();
    // WorkerModel worker = await RecommendationDatabase.getRecommendedWorker("XijqsEXSqx7GX8gBMwQJ");
    // SubServiceModel subb = await RecommendationDatabase.getRecommendedSubService("XijqsEXSqx7GX8gBMwQJ");
    setState(() {});
    for (int i = 0; i < services.length; i++) {
      servicesNames.add(services[i].title);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent
                ),
                height: 72,
                alignment: Alignment.topCenter,
                child: Card(
                  //color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4,
                  child: Container(
                    child: SearchField(
                      controller: searchCont,
                      onSubmit: (value){
                        print(value);
                      },

                      suggestionsDecoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(12),
                        color:Theme.of(context).scaffoldBackgroundColor,
                      ),
                      itemHeight: 40,
                      suggestions: servicesNames.map((item) => SearchFieldListItem<String>(item)).toList(),
                      onSuggestionTap: (SearchFieldListItem<String> suggestion)async{
                        print(searchCont.text);
                       var serviceRes =  await ServiceDatabase.searchServiceByTitle2(searchCont.text);
                       var service = serviceRes[0];
                       Navigator.pushNamed(context, SelectedServiceView.routeName,arguments: service);
                      },
                      searchInputDecoration: InputDecoration(
                          prefixIcon:  Icon(
                            Icons.search,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          hintText: AppLocalizations.of(context)!.search_bar,
                          // hintStyle: TextStyle(
                          //   fontSize: 12
                          // ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 8),
              //margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (buildContext, index) {
                  return AdWidget(ad: ads[index]);
                },
                itemCount: ads.length,
              ),
            ),
             const SizedBox(
              height: 20,
            ),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppLocalizations.of(context)!.packages,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppLocalizations.of(context)!.services,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              //margin: EdgeInsets.symmetric(horizontal: 10),
              //child: ListView(
              // children:[
              child: GridView.builder(
                itemCount: services.length < 8 ? services.length + 1 : 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return services.length != 0
                      ? index == 8 || index == services.length
                          ? MoreServiceWidget(
                              service: services[0],
                              title: services[0].title,
                              imagePath: services[0].imageUrl)
                          : ServiceWidget(
                              service: services[index],
                              imagePath: services[index].imageUrl,
                              title: services[index].title,
                            )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
              //  ]
            ),
            const SizedBox(
              height: 20,
            ),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppLocalizations.of(context)!.recommended,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (buildContext, index) {
                  return RecommendedWidget(
                      recommendationModel: recommends[index]);
                },
                itemCount: recommends.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
