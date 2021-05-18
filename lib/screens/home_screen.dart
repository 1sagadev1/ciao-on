import 'package:ciaooo/screens/welcome_screen.dart';
import 'package:ciaooo/widgets/image_slider.dart';
import 'package:ciaooo/widgets/my_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:ciaooo/widgets/my_appbar.dart';
class HomeScreen extends StatefulWidget{
  static const String id = 'home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _location = '';
  @override
  void initState(){
    getPrefs();
    super.initState();
  }
  getPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString('location');
    setState(() {
      _location=location;
    });
  }
  @override
  Widget build(BuildContext context){
    //final auth = Provider.of<AuthProvider>(context);
    //final locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(112),
        child: MyAppBar(),
      ),
      body: Center(
          child: Column(
            // ignore: deprecated_member_use
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageSlider(),
            ElevatedButton(
              onPressed: (){
              //auth.error = '';
              FirebaseAuth.instance.signOut().then((value){
              Navigator.push(context,MaterialPageRoute(
                builder: (context)=>welcomescreen(),
                ));
                });
               },
                child: Text('Sign Out'),
                  ),
            // ignore: deprecated_member_use
            RaisedButton(
                onPressed:(){
                  Navigator.pushNamed(context,welcomescreen.id);
                },
              child: Text('Home Screen'),
              ),
              ]
              ),
            ),
    );
          }
}


