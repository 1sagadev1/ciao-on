

import 'dart:io';

import 'package:ciaooo/providers/location_provider.dart';
import 'package:ciaooo/screens/home_screen.dart';
import 'package:ciaooo/screens/landing_screen.dart';
import 'package:ciaooo/screens/login_screen.dart';
import 'package:ciaooo/services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ciaooo/screens/map_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ciaooo/providers/location_provider.dart';
import 'package:ciaooo/services/vendor_services.dart';
import 'package:ciaooo/screens/landing_screen.dart';


class AuthProvider with ChangeNotifier {
  File image;
  bool isPicAvail = false;
  String PickerError = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOtp;
  String verificationID;
  String error = '';
  UserServices _userServices = UserServices();

  bool loading = false;
  LocationProvider locationData = LocationProvider();
  String screen;
double  latitude;
double longitude;
  //24.35
  String address;
  String email = '';
  String location;

  Future<File> getImage()async{
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery,);

    if(pickedFile != null){
      this.image = File(pickedFile.path);
      notifyListeners();
    }else{
      this.PickerError = 'No image selected ';
      print('no image selected.');
      notifyListeners();
    }
    return this.image;
  }
  Future<void> verifyphone({BuildContext context, String number, }) async {
    this.loading = true;
    notifyListeners();
    final verificationcompleted = (PhoneAuthCredential credential) async {
      this.loading = false;
      notifyListeners();
      await _auth.signInWithCredential(credential);
    };
    final PhoneVerificationFailed verificationFailed = (
        FirebaseAuthException e) {
      this.loading = false;
      print(e.code);
      this.error = e.toString();
      notifyListeners();
    };
    final PhoneCodeSent smsOtpSend = (String verID, int resendToken) async {
      this.verificationID = verID;
      //open dialog to enter the recieved otp sms
      //
      // smsOtpDialog(context,number);
      smsOtpDialog(context, number);
    };

//7032882945
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationcompleted,
        verificationFailed: null,
        codeSent: smsOtpSend,
        codeAutoRetrievalTimeout: (String veriId) {
          this.verificationID = veriId;
        },);
    } catch (e) {
      this.error = e.toString();
      this.loading = false;

      notifyListeners();
      print(e);
    }
  }
  Future<bool> smsOtpDialog(BuildContext context, String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(' verification code'),
                SizedBox(height: 6,),
                Text('Enter the recieved 6 digit code to enter the app',
                  style: TextStyle(fontSize: 8,),),

              ],
            ),
            content: Container(
              height: 85,
              child: TextField(

                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              FlatButton(onPressed: () async {

                try {
                  PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationID, smsCode: smsOtp);
                 final  User  user = (await _auth.signInWithCredential(
                      phoneAuthCredential)).user;
                 _createUser(id: user.uid,number: user.phoneNumber);
                if(user != null){

                  this.loading = false;
                  notifyListeners();
                  _userServices.getUserById(user.uid).then((snapShot) {
                    if( snapShot.exists){
                      if(this.screen=='Login'){
                        //checking wether it exists in db or not
                        //if yes data will update or create new data
                        Navigator.restorablePushReplacementNamed(context,LandingScreen.id);

                      }else{
                        updateUser(id : user.uid,number: user.phoneNumber);
                        Navigator.pushReplacementNamed(context, homepage.id);
                      }
                    }else{
                      //will create new data in db

                      _createUser(id: user.uid,number: user.phoneNumber);
                      Navigator.pushReplacementNamed(context, LandingScreen.id);
                    }
                  } );
                //  print(this.screen);

                }else{
                  print('login failed');
                }
                } catch (e) {
                  notifyListeners();

                  this.error = 'Invalid otp';
                  print(e.toString());
                  Navigator.of(context).pop();
                }
              },  color: Colors.black,
                  child: Text('Done', style: TextStyle(color: Colors.white),))
            ],
          );
        }
    ).whenComplete((){
      this.loading =false;
      notifyListeners();
    });
  }
  //Future<void>saveVendorDatatodb(
     // { String url, String shopname,String mobile,String dialog,String email}
     // );


  void _createUser(
      {String id, String number}) {
    _userServices.createUser({
      'id': id,
      'number': number,
   'latitude': this.latitude,
      'longitude': this.longitude,

      'address': this.address,

    });
    this.loading =false;
    notifyListeners();
  }
     updateUser({String id, String number,}) {
      _userServices.updateUserData({
        'id': id,
        'number': number,
        'latitude': this.latitude,
        'longitude': this.longitude,

        'address': this.address,

      });
      this.loading =false;
      notifyListeners();
    }
  }
//registration of vendor
