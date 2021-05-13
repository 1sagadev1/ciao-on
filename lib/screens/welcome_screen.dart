import 'package:ciaooo/screens/onboard_screen.dart';
import 'package:flutter/material.dart';
class welcomescreen extends StatelessWidget {
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
                  onPressed: (){},
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
