import 'package:ciaooo/providers/auth_provider.dart';
import 'package:ciaooo/providers/location_provider.dart';
import 'package:ciaooo/screens/map_screen.dart';
import 'package:ciaooo/screens/onboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
class welcomescreen extends StatefulWidget {
  static const String id = 'welcome-screen';

  @override
  _welcomescreenState createState() => _welcomescreenState();
}

class _welcomescreenState extends State<welcomescreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();
    void showBottom(context){
      showModalBottomSheet(context: context, builder: (context)=>StatefulBuilder(
        builder: (context, StateSetter myState){
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: auth.error=='Invalid otp'? true:false,
                    child: Expanded(
                      child: Container(
                        child: Column(
                          children: [

                            Text('${auth.error}-try again',style: TextStyle(color: Colors.red,fontSize: 12),),
                            SizedBox(height: 5,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text('Login',style:
                  TextStyle(fontSize: 20,fontWeight: FontWeight.bold), ),
                  Text('Enter your mobile number',style:
                  TextStyle(fontSize: 15),),
                  SizedBox(
                    height: 5,),
                  TextField(
                    decoration: InputDecoration(
                      prefixText: '+91',
                      labelText: '10 digit mobile number',


                    ),
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _phoneNumberController ,
                    onChanged: (value) {
                      if (value.length == 10) {
                        myState(() {
                          _validPhoneNumber = true;
                        });
                      }
                      else {
                        myState(() {
                          _validPhoneNumber = false;
                        });
                      }
                    },
                  ),

                  SizedBox(
                    height: 5 ,
                  ),
                  Row(
                    children:[ Expanded(
                      child: AbsorbPointer(
                        absorbing: _validPhoneNumber ? false : true,
                        child: FlatButton(
                          onPressed: (){
                            myState((){
                              auth.loading =  true;
                            });
                            String number = '+91${
                                _phoneNumberController.text
                            }';
                            auth.verifyphone(context : context, number:number).then((value){
                              _phoneNumberController.clear();
                            });
                          },
                          color:_validPhoneNumber ?  Colors.green  : Colors.grey,
                          child: auth.loading?CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ):Text(_validPhoneNumber ? ' continue' : 'Enter', style: TextStyle(color: Colors.white),),

                        ),
                      ),
                    ),
                    ],
                  )

                ],
              ),
            ),
          );
        },
      ),
      ).whenComplete((){
        setState(() {
          auth.loading=false;
          _phoneNumberController.clear();
        });
      });

    }
    final locationData = Provider.of<LocationProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body:

      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,

               child: TextButton(
                   child: Text('SKIP'),
             onPressed: (){},
           ),
            ),

            Column(
              children: [
                Expanded(child: onboardscreen()),
                Text('Get ready to experience the fun '),
                SizedBox(height: 20,),
                FlatButton(

                  color: Colors.black,

                  child:locationData.loading?CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ): Text('set location of your college',style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    setState(() {
                      locationData.loading =true;

                    });
                  await locationData.getCurrentPosition();
                  if(locationData.permissionAllowed == true){

                      Navigator.pushReplacementNamed(context, mapscreen.id);
                      setState(() {
                        locationData.loading = false;
                      });

                  }else{
                    print('permission not allowed');
                    setState(() {
                      locationData.loading = false;
                    });
                  }
                  },
                ),
                SizedBox(height: 20,),
                FlatButton(
                  child: RichText(text: TextSpan(
                    text:'already had an account?',style: TextStyle( color: Colors.black ),
                    children:[
                      TextSpan(
                        text:'login',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple,),

                      ),
                    ],
                  ),
                  ),
                  onPressed: (){showBottom(context);
                  setState(() {
                    auth.screen='Login';
                  });},

                ),],
            ),
          ],
        ),
      ),
    );
  }
}
