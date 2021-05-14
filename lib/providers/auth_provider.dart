import 'dart:js';

import 'package:ciaooo/screens/home_screen.dart';
import 'package:ciaooo/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ciaooo/services/user_services.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOtp;
  String verificationID;
  String error = '';
//UserServices = _userServices UserServices();
  Future<void> verifyphone(BuildContext context, String number) async {
    final verificationcompleted = (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    };
    final PhoneVerificationFailed verificationfailed = (
        FirebaseAuthException e) {
      print(e.code);
    };
    final PhoneCodeSent smsOtpSend = (String verID, int resendToken) async {
      this.verificationID = verID;
      //open dialog to enter the recieved otp sms
      //
      // smsOtpDialog(context,number);
      smsOtpDialog(context, number);
    };


    try {
      _auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationcompleted,
          verificationFailed: null,
          codeSent: null,
          codeAutoRetrievalTimeout: null);
    } catch (e) {

      print(e);
    }
  }

  Future<bool>smsOtpDialog(BuildContext context,String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Column(
              children: [
                Text(' verification code'),
                SizedBox( height: 6,),
                Text('Enter the recieved 6 digit code to enter the app'),

              ],
            ),
            content: Container(
              height: 85,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value){
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              FlatButton(onPressed: () async{
                try {
                    PhoneAuthCredential  phoneAuthCredential =
                      PhoneAuthProvider.credential(
                        verificationId : verificationID , smsCode: smsOtp);
             final User user =      ( await _auth.signInWithCredential(phoneAuthCredential)).user;

                          //NAVIGATE TO HOME page  after clicking login button
                        if(user!= null){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder:(context)=> homepage(),
                  ));

                    }else{
                          print('login failed');
                        }




                }catch (e) {

                  this.error = 'Invalid otp';
                  print(e.toString());
                  Navigator.of(context).pop();



                }
              } , child: Text('Done'))
            ],
          );
        }
    );
  }

}