import 'package:ciaooo/screens/welcome_screen.dart';
import 'package:ciaooo/services/store_services.dart';
import 'package:ciaooo/services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class TopPickStore extends StatefulWidget{


  @override
  _TopPickStoreState createState() => _TopPickStoreState();
}
class _TopPickStoreState extends State<TopPickStore>{

  User user = FirebaseAuth.instance.currentUser;
  var _userLatitude = 0.0;
  var _userLongitude = 0.0;
  UserServices _userServices =UserServices();
  StoreServices _storeServices = StoreServices();
  @override
  void initState(){
    _userServices.getUserById(user.uid).then((result){
      if(user != null){
        if(mounted){
          setState((){
            _userLatitude = result['latitude'];
            _userLongitude = result['longitude'];
          });
          print(_userLatitude = result['latitude']);
          print(_userLatitude = result['longitude']);
        }
      }else
      {
        Navigator.pushReplacementNamed(context,welcomescreen.id);
      }
    });
    super.initState();
  }
  String getDistance(location){
    var distance = Geolocator.distanceBetween(
        _userLatitude, _userLongitude, location.latitude, location.longitude);
    var distanceInKm = (distance/1000)-7255.792086839187;
    print(distanceInKm);
    return distanceInKm.toStringAsFixed(2);

  }


@override
Widget build (BuildContext context){
  return Container(
    child: StreamBuilder<QuerySnapshot>(
      stream: _storeServices.getTopPickedStore(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapShot){
        if (!snapShot.hasData || snapShot.data.docs.isEmpty)
          return CircularProgressIndicator();

        List shopDistance = [];
        for(int i=0;i<= snapShot.data.docs.length - 1;i++){
          var distance = Geolocator.distanceBetween(
              _userLatitude ,
              _userLongitude,
              snapShot.data.docs[i]['location'].latitude,
              snapShot.data.docs[i]['location'].longitude);

          var distanceInKm = distance/1000;
          shopDistance.add(distanceInKm);
        }
        shopDistance.sort();

        return Padding(
          padding: const EdgeInsets.only(left: 8,right: 8),
          child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        height:30,
                        child: Image.asset('images/seller.png')),
                    Text('Top Sellers For You',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18),),
                  ],
                ),
                Container(
                  child: Flexible(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: snapShot.data.docs.map((DocumentSnapshot document){

                        if(double.parse(getDistance(document['location']))<=10){

                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:80,
                                    height: 80,
                                    child: Card(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: Image.network(document['imageUrl'],fit: BoxFit.cover,)),),

                                  ),
                                  Container(
                                    height: 35,
                                    child: Text(
                                      document['shopname'],style: TextStyle(
                                      fontSize: 14,fontWeight: FontWeight.bold,
                                    ),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ),
                                  Text(
                                    '${getDistance(document['location'])}Km',style: TextStyle(
                                      color: Colors.grey,fontSize: 10
                                  ),)
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Container();
                        }
                      }).toList(),
                    ),
                  ),
                )
              ]
          ),
        );
      },
    ),
  );
}
}

