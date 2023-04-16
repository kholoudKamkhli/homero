import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homero/database/user_database.dart';
import 'package:homero/models/user_model.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/screens/orders/orders_view.dart';
import 'package:homero/screens/profile/payment_history.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'scheduled_view.dart';
import 'edit_profile.dart';
class ProfileView extends StatefulWidget {
  static const String routeName = "Profile";
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  MyUser ? user;
  var image;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    initUser();

  }
  Future<void> initUser() async {
    print("we are initting user");
    print(FirebaseAuth.instance.currentUser!.uid);
    user = await UserDatabase.getUser(FirebaseAuth.instance.currentUser!.uid);
    if(user!.imageUrl==""){
      image = AssetImage("assets/images/img_10.png");
    }
    else{
      image = NetworkImage(user!.imageUrl);
    }
    setState(() {

    });
  }
  final ImagePicker _picker = ImagePicker();
  XFile? _image ;
  @override
  Widget build(BuildContext context) {
    return user==null?Center(child: CircularProgressIndicator(),):Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: Theme.of(context).appBarTheme.titleTextStyle,

        ),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back,
              ),
          onPressed: () => Navigator.pushReplacementNamed(context, HomeScreenView.routeName),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: image,

              ),
              ),
            const SizedBox(
              height: 20,
            ),
             Text(
              user!.username,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, EditProfile.routeName);
              },
              child:  Text(
                AppLocalizations.of(context)!.edit_profile,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(255, 126, 127, 131),
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: 328,
              height: 1,
              decoration:const BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: (){},
              child: Padding(
                padding:const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(
                       Icons.notifications_none,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(
                        AppLocalizations.of(context)!.notifications,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Icon(Icons.navigate_next,
                        color: Theme.of(context).textTheme.displayMedium!.color)
                  ],
                ),
              ),
            ),
            Container(
              width: 270,
              height: 1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, OrdersView.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(
                      Icons.menu_book_outlined,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text(
                        AppLocalizations.of(context)!.my_orders,
                        style: Theme.of(context).textTheme.displayMedium,

                      ),
                    ),
                    Icon(Icons.navigate_next,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 270,
              height: 1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, ScheduledOrdersView.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(
                      Icons.library_books,
                      color: Theme.of(context).textTheme.displayMedium!.color,

                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,

                      child: Text(
                        AppLocalizations.of(context)!.schedule,
                        style: Theme.of(context).textTheme.displayMedium,

                      ),
                    ),
                    Icon(Icons.navigate_next,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 270,
              height: 1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),
              ),
            ),
            InkWell(
              onTap: (){

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(
                      Icons.wallet,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,

                      child: Text(
                        AppLocalizations.of(context)!.wallet,
                        style: Theme.of(context).textTheme.displayMedium,

                      ),
                    ),
                    Icon(Icons.navigate_next,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 270,
              height: 1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PaymentHistory.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Icon(
                      Icons.payment,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,

                      child: Text(
                        AppLocalizations.of(context)!.payment,
                        style: Theme.of(context).textTheme.displayMedium,

                      ),
                    ),

                    Icon(Icons.navigate_next,
                        color: Theme.of(context).textTheme.displayMedium!.color)
                  ],
                ),
              ),
            ),
            Container(
              width: 270,
              height: 1,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 126, 127, 131),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Icon(
                      Icons.logout,
                      color: Theme.of(context).textTheme.displayMedium!.color,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,

                      child: Text(

                        AppLocalizations.of(context)!.logout,
                        style: Theme.of(context).textTheme.displayMedium,

                      ),
                    ),
                     Icon(Icons.navigate_next,
                        color: Theme.of(context).textTheme.displayMedium!.color)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
