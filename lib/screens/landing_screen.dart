import 'package:ciaooo/screens/home_screen.dart';
import 'package:ciaooo/screens/map_screen.dart';
import 'package:ciaooo/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ciaooo/providers/location_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '';
class LandingScreen extends StatefulWidget{
  static const String id = 'landing-screen';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen>{
  LocationProvider _locationProvider = LocationProvider();
  User user = FirebaseAuth.instance.currentUser;
  String _location;
  String _address;
  double  latitude;
  double longitude;
  bool loading= true;
  @override
  void  initState(){
    UserServices _userServices = UserServices();
    _userServices.getUserById(user.uid).then((result)async {

      if(result != null){
        if(result['latitude']!=null){
          getPrefs(result);
        }else{
          _locationProvider.getCurrentPosition();
          if(_locationProvider.permissionAllowed==true){
            Navigator.pushNamed(context,mapscreen.id);
          }else{
            print('Permission not allowed');
          }
        }
      }
    });
    super.initState();
  }
  getPrefs(dbResult)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString('location');
    if(location == null) {
      prefs.setString('address', dbResult['location']);
      prefs.setString('address', dbResult['address']);
      if(mounted) {
        setState(() {
          _location = dbResult.data()['location'];
          _address = dbResult.data()['address'];
          loading=false;
        });
      }
      Navigator.pushReplacementNamed(context, homepage.id);
    }
    Navigator.pushReplacementNamed(context, homepage.id);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_location==null ? '': _location),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_address==null ? 'Delivery Address not set': _address,style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_address==null ? 'Please update your Delivery Location to find nearest College to You'
                  : _address,textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            CircularProgressIndicator(),
            Container(
              width: 600,
              child: Image.asset('images/city.png',
                fit: BoxFit.fill,
                color: Colors.black12,),),
            Visibility(
              visible: _location!=null?true:false,
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  Navigator.pushReplacementNamed(context,homepage.id);
                },
                child: Text('Confirm Your Location'),
              ),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: (){
                _locationProvider.getCurrentPosition();
                if(_locationProvider.selectedAddress!=null){
                  Navigator.pushReplacementNamed(context, mapscreen.id);
                }else{
                  print('Permission not Allowed');
                }
                Navigator.pushReplacementNamed(context, homepage.id);
              },
              child: Text(_location!=null ? 'Update Location':'Set Your Location',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}