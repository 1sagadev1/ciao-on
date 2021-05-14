import 'package:ciaooo/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
class welcomescreen extends StatelessWidget {
  bool _validPhoneNumber = false;
  void showBottom(context){
    showModalBottomSheet(context: context, builder: (context)=>StatefulBuilder(
      builder: (context, StateSetter myState){
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), ),
                Text('Enter your mobile number',style: TextStyle(fontSize: 15),),
                SizedBox(height: 5,),
                TextField(
                  decoration: InputDecoration(
                    prefixText: '+91',
                    labelText: '10 digit mobile number',


                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
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
                        color:_validPhoneNumber ?  Colors.green  : Colors.grey,
                        child: Text(_validPhoneNumber ? ' continue' : 'Enter', style: TextStyle(color: Colors.white),),
                        onPressed: (){},
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
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,

               child: FlatButton(
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
                  color: Colors.yellow,
                  child: Text('set location of your college'),
                  onPressed: (){
                    showBottom(context);
                  },
                ),
                SizedBox(height: 20,),
                FlatButton(
                  child: RichText(text: TextSpan(
                    text:'already had an account?',style: TextStyle( color: Colors.black ),
                    children:[
                      TextSpan(
                        text:'login',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),

                      ),
                    ],
                  ),
                  ),
                  onPressed: (){},

                ),],
            ),
          ],
        ),
      ),
    );
  }
}
