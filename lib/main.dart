import 'dart:async';

import 'package:flutter/material.dart';
import 'screens/Registerscreen.dart';
import 'screens/onboard_screen.dart';
import 'screens/welcome_screen.dart';
void main() {
  runApp(MyApp());
}


 class MyApp extends StatelessWidget {
   @override

   Widget build(BuildContext context) {
     return MaterialApp(
       home: Splashscreen(),
     );
   }
 }

 class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
  Timer(
    Duration(seconds: 3,
    ),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder:(context)=>welcomescreen(),
      ));
  }
  );
    super.initState();
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       body: Center(
         child: Hero
           (
             tag : 'logo',
             child: Image.asset('images/9.png')),



      ),
     );
   }
}
