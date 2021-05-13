import 'package:flutter/material.dart';
class Registerscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          children: [
            Hero
              ( tag:'logo',

                child: Image.asset('images/9.png')),
            TextField(),
            TextField(),
            TextField(),
            TextField(),



          ],
        ),
      ),
    );
  }
}
