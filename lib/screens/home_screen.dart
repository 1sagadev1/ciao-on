import 'package:ciaooo/providers/auth_provider.dart';
import 'package:ciaooo/providers/location_provider.dart';
import 'package:ciaooo/screens/top_pick_store.dart';
import 'package:ciaooo/screens/welcome_screen.dart';
import 'package:ciaooo/widgets/image_slider.dart';
import 'package:ciaooo/widgets/my_appbar.dart';
import 'package:ciaooo/widgets/register_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class homepage extends StatefulWidget{
  static const String id = 'home-screen';

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override
  Widget build(BuildContext context){
    final auth = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(112),

        child: MyAppBar(),
      ),
      body: Center(
        child: Column(
          //  mainAxisSize: MainAxisSize.min,
            children: [
               ImageSlider(),
                Container(
                  height: 300,
                  child: TopPickStore(),
                ),


      ],
    ),

    ),
    );
  }
}
