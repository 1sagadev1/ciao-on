
 import 'package:ciaooo/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  String collection = 'users';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // creating a new user
Future<void> createUser(Map<String , dynamic>values) async{
  String id = values['id'];
  await _firestore.collection(collection).doc(id).set(values);
}
//update user data

Future<void>updateUserData(Map<String , dynamic>values)async{
  String id = values['id'];
  await _firestore.collection(collection).doc(id).update(values);
}

  Future<DocumentSnapshot>getUserById(String id)async{
    //String id = values['id'];
  var result =   await _firestore.collection(collection).doc(id).get();

      return result;


  }
// gwt user data by user id
 }