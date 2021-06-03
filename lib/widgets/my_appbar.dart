import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ciaooo/screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:ciaooo/providers/location_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ciaooo/screens/welcome_screen.dart';

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}
class _MyAppBarState extends State<MyAppBar>{

  String _location ='';
  String _address = '';
  @override
  void initState(){
    getPrefs();
    super.initState();
  }
  getPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString('location');
    String address = prefs.getString('address');
    setState(() {
      _location= location;
      _address =address;
    });
  }
  @override
  Widget build(BuildContext context){
    final locationData = Provider.of<LocationProvider>(context);
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      title: TextButton(
        onPressed: (){
          locationData.getCurrentPosition();
          if(locationData.permissionAllowed==true){
            Navigator.pushNamed(context, mapscreen.id);
          }else{
            print('Permission Not Allowed');
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(_location==null?'ADDRESS NOT SET' : _location,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    overflow:TextOverflow.ellipsis,),
                ),
                Icon(Icons.edit_outlined,
                  color: Colors.white,
                  size: 15,
                ),
              ],
            ),
            Flexible(child: Text(_address == null ? 'press here to set delivery location' : _address,overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white,fontSize: 12),
            )),
          ],
        ),
      ),
      actions: [
        IconButton(icon: Icon(Icons.power_settings_new,color: Colors.white,),
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, welcomescreen.id);
          },),
        IconButton(icon: Icon(Icons.account_circle_outlined,color: Colors.white,),onPressed: (){},),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search,color: Colors.grey,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.zero,
              filled:true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}