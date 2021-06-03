import 'package:ciaooo/widgets/image_picker.dart';
import 'package:ciaooo/widgets/register_form.dart';
import 'package:flutter/material.dart';
class registerscreen extends StatelessWidget {
  static const String id = 'register-screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       backgroundColor: Colors.white,
        body:  Center(
          child :
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                   shoppiccard(),
                  registerform(),


                ],
              ),
            ),
          ),
        ),
    ),
    );
    
  }
}
