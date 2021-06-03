import 'dart:async';

import 'package:ciaooo/screens/home_screen.dart';
import 'package:ciaooo/screens/landing_screen.dart';
import 'package:ciaooo/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Splashscreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    Timer(
        Duration(seconds: 3,
        ),(){
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if(user==null){
       Navigator.pushReplacementNamed(context, welcomescreen.id);
        }else{
        Navigator.pushReplacementNamed(context, LandingScreen.id);
        }
      });
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
