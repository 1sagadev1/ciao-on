import 'package:cloud_firestore/cloud_firestore.dart';
class StoreServices{
  getTopPickedStore(){
    return FirebaseFirestore.instance.collection('vendors').where('isTopPicked',isEqualTo: true).where('shopopen', isEqualTo: true).snapshots();
  }
}