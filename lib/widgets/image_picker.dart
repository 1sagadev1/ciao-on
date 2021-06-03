import 'dart:io';

import 'package:ciaooo/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class shoppiccard extends StatefulWidget {


  @override
  _shoppiccardState createState() => _shoppiccardState();
}

class _shoppiccardState extends State<shoppiccard> {
  File _image;
  @override
  Widget build(BuildContext context) {
   final _authData = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: (){
       _authData.getImage().then((image){
         setState(() {
           _image = image;

         });
if(image!= null){
  _authData.isPicAvail =  true;
}
print(_image.path);
})  ;
        },
        child: SizedBox(
          height:150 ,
          width: 150,
          child: Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: _image == null ? Center(child: Text('add shop image',// no image pivker
                  style: TextStyle(color: Colors.grey),
                )
                ):Image.file(_image , fit: BoxFit.cover
                  ,),
              )//after picking image
          ),
        ),
      ),
    );
  }
}
