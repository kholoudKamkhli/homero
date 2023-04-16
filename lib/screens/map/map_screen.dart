import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homero/database/order_database.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:homero/shared/dialog_utils.dart';
import 'package:intl/intl.dart';
import "package:latlong2/latlong.dart" as latLng;

import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';



class MapScreen extends StatefulWidget {
  static const String routeName = "mapScreen";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? pickUpPoint;
  var latLang;
  var first;

  @override
  Widget build(BuildContext context) {
    var order = ModalRoute.of(context)?.settings!.arguments as OrderModel;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.8,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(30.0444, 31.2357), zoom: 14),
              markers: {
                if (pickUpPoint != null) pickUpPoint!,
              },
              onLongPress: addMarker,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
              color: Color.fromARGB(24, 255, 255, 255),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("choose pich up point then click on continue",style: TextStyle(
                  color: Colors.black54,
                  fontSize:12 ,
                  fontWeight: FontWeight.w500,
                ),),
                SizedBox(height: 10,),
                InkWell(
                  onTap: ()async{
                    if(pickUpPoint!=null){
                      var pos=pickUpPoint!.position;
                      final coordinates =
                      new Coordinates(pos.latitude,pos.longitude);
                      var address =
                          await Geocoder.local.findAddressesFromCoordinates(coordinates);
                      first = address.first;
                      order.pickUpPoint=first?.addressLine?.toString();
                      OrderDatabase.addOrder(order);
                      MyDialogUtils.showAnotherMessage(context, "Your Order has been placed successfuly ", "Ok",posAction: (){
                        Navigator.pushNamed(context, HomeScreenView.routeName);
                      });
                      //Navigator.pushNamed(context, HomeScreenView.routeName);
                    }
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    height: 58,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color.fromARGB(255, 52, 205, 196),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  addMarker(LatLng pos) {
    {

      pickUpPoint = Marker(
        onDragEnd: (LatLng newPos) async {
          latLang = newPos;
          final coordinates =
          new Coordinates(latLang.latitude,latLang.longitude);
          var address =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
           first = address.first;
           print(first?.addressLine?.toString());

        },
        markerId: MarkerId("pick up point"),
        infoWindow: InfoWindow(title: "Pick Up Point"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        position: pos,
      );
    }
    setState(() {

    });
  }
}
