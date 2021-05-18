//import 'dart:html';
import 'package:ciaooo/screens/onboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable, camel_case_types
class welcomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();
    void showBottomSheet(context){
      showModalBottomSheet(
        context: context,
        builder: (context)=>  StatefulBuilder(
          builder: (context,StateSetter myState){
            var auth;
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: auth.error=='Invalid OTP' ? true:false,
                      child: Container(
                       child: Column(
                        children:[
                          Text(auth.error,style: TextStyle(color: Colors.red,fontSize: 12),),
                        ],
                      ),
                     ),
                    ),
                        Text('Login',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text('Enter your phone number',style: TextStyle(fontSize: 12,color: Colors.grey),),
                        SizedBox(height: 30,),
                        TextField(
                      decoration: InputDecoration(
                        prefixText:  "+91",
                        labelText: '10 digit num ',
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      controller: _phoneNumberController,
                      onChanged: (value){
                        if(value.length==10){
                          myState((){
                            _validPhoneNumber = true;
                          });
                        }else {
                          myState(() {
                            _validPhoneNumber = false;
                          });
                        }
                      },
                    ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                           Expanded(
                            child: AbsorbPointer(
                            absorbing: _validPhoneNumber ? false:true,
                            // ignore: deprecated_member_use
                             child: FlatButton(
                              onPressed: () {
                                myState(() {
                                  auth.loading = true;
                                });
                                String number = '+91${_phoneNumberController
                                    .text}';
                                auth.verifyPhone(context: context,
                                    number: number,
                                    latitude: null,
                                    longitude: null).then((value) {
                                  _phoneNumberController.clear();
                                });
                              },
                              color: _valid PhoneNumber ? Theme.of(context).primaryColor : Colors.grey,
                              child: auth.loading ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                              ): Text(_validPhoneNumber ? 'Continue' : 'Enter phone num',style: TextStyle(color: Colors.white),),
                            );
                          ),
                        ),
                      ),
                      ],
                    ),
                ),
              ),
            );
          },
        ),
      ).whenComplete((){
        setState((){
          auth.loading=false;
          _phoneNumberController.clear();
            });
            });
    }
    //final locationData = Provider.of<LocationProvider>(context,listen:false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text(
                    'SKIP',
                    style: TextStyle(color: Theme.of(context).primaryColor),
              ),
                onPressed: (){},
              ),
            ),
            Column(
              children: [
                Expanded(child: onboardscreen(),
                ),
                Text(
                  'Get ready to experience the fun ',
                  style: TextStyle(color: Colors.grey),),
                SizedBox(height: 20,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: locationData.loading ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ) : Text(
                      'set location of your college',
                      style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    setState((){
                      locationData.loading=true;
                     // auth.latitude=locationData.latitude;
                      //auth.longitude=locationData.longitude;
                      //auth.address= locationData.selectAddress.addressLine;
                      });

                   await locationData.getCurrentPosition();
                    if(locationData.permissionAllowed==true){
                     // Navigator.pushReplacementNamed(context,MapScreen.id);
                      setState((){
                        locationData.loading=false;
                        });
                }else{
                      print('permission not allowed');
                      setState((){
                        locationData.loading=false;
                      });
                    }
                },
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: RichText(
                    text: TextSpan(
                    text:'already had an account?',
                    style: TextStyle( color: Colors.grey ),
                    children:[
                      TextSpan(
                        text:'login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent)),
                      ],
                    ),
                  ),
                  onPressed: () {
                    setState((){
                      auth.screen ='Login';
                      });
                      showBottomSheet(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
