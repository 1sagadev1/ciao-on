
import 'package:ciaooo/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorServices{
  String collection = 'vendors';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // creating a new user
  Future<void> createvendor(Map<String , dynamic>values) async{
    String id = values['id'];
    await _firestore.collection(collection).doc(id).set(values);
  }
//update user data



  }
// gwt user data by user id
