import 'package:flutter/material.dart';
import 'package:ciaooo/providers/auth_provider.dart';
//import 'package:ciaooo/providers/location_provider.dart';
import 'package:ciaooo/screens/home_screen.dart';
import 'package:provider/provider.dart';
class LoginScreen extends StatefulWidget{
  static const String id = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
    //final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController =TextEditingController();
    @override
    Widget build(BuildContext context){
      final auth = Provider.of<AuthProvider>(context);
      final locationData = Provider.of<LocationProvider>(context);
      return Scaffold(
       body: SafeArea(
         child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  onChanged: (value){
                    if(value.length==10){
                      setState((){
                        _validPhoneNumber = true;
                      });
                    }else {
                      setState(() {
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
                            //print(locationData.longitude);
                            setState((){
                              auth.loading=true;
                              auth.screen = 'MapsScreen';
                              auth.latitude = locationData.latitude;
                              auth.longitude = locationData.longitude;
                              auth.address = locationData.selectedAddress.addressLine;

                            });
                            String number ='+91${_phoneNumberController.text}';
                            auth.verifyPhone(
                                context: context,
                                number: number,
                                latitude: locationData.latitude,
                                longitude:locationData.longitude,
                                address: locationData.selectedAddress.addressLine
                            ).then((value){
                              _phoneNumberController.clear();
                              setState(() {
                                auth.loading= false; //to disable circle indicator
                              });
                            });
                            Navigator.pushReplacementNamed(context, HomeScreen.id);
                          },
                          color: _validPhoneNumber ? Theme.of(context).primaryColor : Colors.grey,
                          child: auth.loading ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                          ): Text(_validPhoneNumber ? 'Continue' : 'Enter phone num',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
      ),
       )
      );
    }
  }