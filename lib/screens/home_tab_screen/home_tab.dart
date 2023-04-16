import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/database/service_database.dart';
import 'package:homero/models/ad_model.dart';
import 'package:homero/models/reccomendation_model.dart';
import 'package:homero/models/service_model.dart';
import 'package:homero/screens/home_tab_screen/widgets/more_service_widget.dart';
import 'package:homero/screens/services/selected_service_view.dart';
import 'package:homero/view_models/ads_view_model.dart';
import 'package:homero/view_models/service_view_model.dart';
import 'package:searchfield/searchfield.dart';
import '../../view_models/recommendations_view_model.dart';
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
  List<String> servicesNames = [];
  var searchCont = TextEditingController();
  HomeViewModel homeViewModel = HomeViewModel();
  AdsViewModel adsViewModel = AdsViewModel();
  RecommendationViewModel recommendationViewModel = RecommendationViewModel();
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

  initServices() async {
    homeViewModel.initServices();
    adsViewModel.initAds();
    recommendationViewModel.initRecommends();

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
                  color: Colors.transparent),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent),
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
                      onSubmit: (value) {
                        print(value);
                      },
                      suggestionsDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      itemHeight: 40,
                      suggestions: servicesNames
                          .map((item) => SearchFieldListItem<String>(item))
                          .toList(),
                      onSuggestionTap:
                          (SearchFieldListItem<String> suggestion) async {
                        print(searchCont.text);
                        var serviceRes =
                            await ServiceDatabase.searchServiceByTitle2(
                                searchCont.text);
                        var service = serviceRes[0];
                        Navigator.pushNamed(
                            context, SelectedServiceView.routeName,
                            arguments: service);
                      },
                      searchInputDecoration: InputDecoration(
                          prefixIcon: Icon(
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
            BlocProvider<AdsViewModel>(
              create: (_)=>adsViewModel,
              child: Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<AdsViewModel, AdsState>(
                  builder: (context, state) {
                    if (state is AdsErrorState) {
                      return Center(
                        child: Text(state.errorMessage),
                      );
                    } else if (state is AdsloadedState) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (buildContext, index) {
                          return AdWidget(ad: state.ads[index]);
                        },
                        itemCount: state.ads.length,
                      );
                    } else if (state is LoadingAdsState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text("Something went wrong");
                    }
                  },
                ),
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
            BlocProvider<HomeViewModel>(
              create: (_)=>homeViewModel,
              child: BlocBuilder<HomeViewModel, HomeState>(
                builder: (context, state) {
                  if (state is ServicesErrorState) {
                    return Container(
                      height: 200,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(state.errorMessage)),
                      ),
                    );
                  } else if (state is ServicesloadedState) {
                    return Container(
                        height: 200,
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GridView.builder(
                          itemCount: state.services.length < 8
                              ? state.services.length + 1
                              : 8,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (context, index) {
                            return state.services.length != 0
                                ? index == 8 || index == state.services.length
                                    ? MoreServiceWidget(
                                        service: state.services[0],
                                        title: state.services[0].title,
                                        imagePath: state.services[0].imageUrl)
                                    : ServiceWidget(
                                        service: state.services[index],
                                        imagePath:
                                            state.services[index].imageUrl,
                                        title: state.services[index].title,
                                      )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
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
            BlocProvider<RecommendationViewModel>(
              create: (_)=>recommendationViewModel,
              child: BlocBuilder<RecommendationViewModel, RecommendsState>(builder: (context, state) {
                if (state is ErrorRecommendsState) {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else if (state is RecommendsLoadedState) {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (buildContext, index) {
                        return RecommendedWidget(
                            recommendationModel: state.recommends[index]);
                      },
                      itemCount: state.recommends.length,
                    ),
                  );
                } else {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
// Container(
//   height: 200,
//   padding: EdgeInsets.symmetric(horizontal: 8.0),
//   //margin: EdgeInsets.symmetric(horizontal: 10),
//   //child: ListView(
//   // children:[
//   child: GridView.builder(
//     itemCount: services.length < 8 ? services.length + 1 : 8,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 4,
//       childAspectRatio: 1.0,
//     ),
//     itemBuilder: (context, index) {
//       return services.length != 0
//           ? index == 8 || index == services.length
//               ? MoreServiceWidget(
//                   service: services[0],
//                   title: services[0].title,
//                   imagePath: services[0].imageUrl)
//               : ServiceWidget(
//                   service: services[index],
//                   imagePath: services[index].imageUrl,
//                   title: services[index].title,
//                 )
//           : Center(
//               child: CircularProgressIndicator(),
//             );
//     },
//   ),
//   //  ]
// ),
