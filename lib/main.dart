

import 'package:ciaooo/providers/auth_provider.dart';
import 'package:ciaooo/providers/location_provider.dart';
import 'package:ciaooo/screens/home_screen.dart';
import 'package:ciaooo/screens/landing_screen.dart';
import 'package:ciaooo/screens/login_screen.dart';
import 'package:ciaooo/screens/map_screen.dart';
import 'package:ciaooo/services/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ciaooo/screens/Registerscreen.dart';
import 'providers/store_provider.dart';

import 'screens/welcome_screen.dart';
void main() async{
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> AuthProvider()),
      ChangeNotifierProvider(create: (_)=> LocationProvider()),
      ChangeNotifierProvider(create: (_)=> StoreProvider()),
    ],
    child: MyApp(),
  ),);
}


 class MyApp extends StatelessWidget {
   @override

   Widget build(BuildContext context) {
     return MaterialApp(


       debugShowCheckedModeBanner: false,
       theme: ThemeData(
          primaryColor: Colors.black,
           fontFamily: 'Lato',
       ),
       home: Splashscreen(),
       initialRoute: Splashscreen.id,
       routes: {
         Splashscreen.id :(context)=>Splashscreen(),
         homepage.id:(context)=>homepage(),
         welcomescreen.id:(context)=>welcomescreen(),
         mapscreen.id:(context)=>mapscreen(),
         loginscreen.id:(context)=>loginscreen(),
         registerscreen.id:(context)=>registerscreen(),
         LandingScreen.id:(context)=>LandingScreen(),

       },
     );
   }
 }

