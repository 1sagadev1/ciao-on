import 'dart:io';

import 'package:ciaooo/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:ciaooo/providers/location_provider.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:ciaooo/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ciaooo/widgets/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ciaooo/screens/home_screen.dart';
class registerform extends StatefulWidget {
  const registerform({Key key}) : super(key: key);

  @override
  _registerformState createState() => _registerformState();
}

class _registerformState extends State<registerform> {

  final _formkey = GlobalKey<FormState>();
  var _emailTextController = TextEditingController();
  var _cpasswordTextController = TextEditingController();
  var _passwordTextController = TextEditingController();
  var _addressTextController = TextEditingController();
  var _nameTextController = TextEditingController();
  var _dialogTextController = TextEditingController();
 LocationProvider locationData = LocationProvider();
  String address;
  String mobile;
  String sellername;
  String dialog;


  Future<String>uploadfile(filepath) async{
    File file = File(filepath);
    FirebaseStorage _storage = FirebaseStorage.instance;
    try{
      await _storage.ref('uploads/sellerprfilepic/${_nameTextController.text}').putFile(file);
    }on FirebaseException catch(e){
      print(e.code);
    }
    String url = await _storage.ref('uploads/sellerprfilepic/${_nameTextController.text}').getDownloadURL();
  return url;
  }
  @override
  Widget build(BuildContext context) {

scaffoldMessage(message){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('message')));
}
    final locationData = Provider.of<LocationProvider>(context);
    final _authData = Provider.of<AuthProvider>(context);
    return Form(

      key : _formkey,

      child: Column(

        children: [
          Padding(

            padding: const EdgeInsets.all(3.0),
            child: TextFormField(

              validator: (value){
                if(value.isEmpty){
                  return 'Enter college name';
                }
                setState(() {
                  _nameTextController.text= value;
                });
                setState(() {
                  sellername = value;
                });
                return null;
              },
decoration: InputDecoration(
  prefixIcon: Icon(Icons.add_business),
  labelText: 'College name',
  contentPadding: EdgeInsets.zero,
  enabledBorder: OutlineInputBorder(),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,color: Theme.of(context).primaryColor
    )
  ),
  focusColor: Theme.of(context).primaryColor
),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              keyboardType: TextInputType.number ,
              maxLength: 10,
              validator: (value){
                if(value.isEmpty){
                  return 'Mobile number';
                }
                setState(() {
                  mobile = value;
                });
                return null;
              },
              decoration: InputDecoration(
                prefixText: '+91',

                  prefixIcon: Icon(Icons.phone),
                  labelText: '+91 ',
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,color: Theme.of(context).primaryColor
                      )
                  ),
                  focusColor: Theme.of(context).primaryColor
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
controller: _emailTextController,
              validator: (value){
                if(value.isEmpty){
                  return 'Email';
                }
                final bool _isValid = EmailValidator.validate(_emailTextController.text);
                if(!_isValid){
                  return 'Invalid Email';
                }
                return null;
              },
              decoration: InputDecoration(

                  prefixIcon: Icon(Icons.email),
                  labelText: 'email ',
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,color: Theme.of(context).primaryColor
                      )
                  ),
                  focusColor: Theme.of(context).primaryColor
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: _passwordTextController,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Password';
                }
                if (value.length < 6) {
                  return 'Minimum 6 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                labelText: 'Password',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Theme
                        .of(context)
                        .primaryColor
                    )
                ),
                focusColor: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: _cpasswordTextController,

              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Confirm Password';
                }
                if (value.length < 6) {
                  return 'Minimum 6 characters';
                }
                if (_passwordTextController.text !=
                    _cpasswordTextController.text) {
                  return 'Password doesn\'t match';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key_outlined),
                labelText: 'Confirm Password',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Theme
                        .of(context)
                        .primaryColor
                    )
                ),
                focusColor: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              maxLines: 6,
              controller: _addressTextController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please press Nvigation Button';
                }

                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.contact_mail_outlined),
                labelText: 'Business Location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.location_searching), onPressed: () {
                  _addressTextController.text = 'Locating...\n Please Wait..';
                  locationData.getCurrentPosition();
                  if(locationData.permissionAllowed==true){
                    _addressTextController.text = '${locationData.selectedAddress.addressLine} ';
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('couldnt find data')));
                  }





                },),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Theme
                        .of(context)
                        .primaryColor
                    )
                ),
                focusColor: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              onChanged: (value){
                _dialogTextController.text = value;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.comment),
                labelText: 'Shop Dialog',
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: Theme
                        .of(context)
                        .primaryColor
                    )
                ),
                focusColor: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
          ),


          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () async{

                    try {
                      Navigator.pushReplacementNamed(context, homepage.id);

                      if (_authData.isPicAvail == true) {
                        if (_formkey.currentState.validate()) {
                          uploadfile(_authData.image.path).then((url) {
                            if (url != null) {
                              //save data to db

                              locationData.Createvendor(

                                url: url,
                                mobile: mobile,
                                shopname: sellername,
                                dialog: _dialogTextController.text,
                                email: _emailTextController.text,

                              );
                            }
                            else {
                              print(
                                  'oooooooooooooooooooooooooooooooooooooooooops');
                              //error message
                              scaffoldMessage('registration failed');
                            }
                          });
                        } else {
                          scaffoldMessage('error');
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                'shop profile pic needed to be uploaded')));
                      }
                    }catch(e){
                      print('error');
                    }
                  },
                  child: Text('Register',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
