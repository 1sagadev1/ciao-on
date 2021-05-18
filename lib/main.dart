import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:ciaooo/screens/home_screen.dart';
import 'package:ciaooo/screens/login_screen.dart';
import 'package:ciaooo/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'screens/welcome_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF84c225),
          fontFamily: 'Lato'
      ),
      //initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id :(context)=>SplashScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        welcomescreen.id:(context)=>welcomescreen(),
        //MapScreen.id:(context)=>MapScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
      },
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
      //FirebaseAuth.instance.authStateChanges().listen((User user))
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
