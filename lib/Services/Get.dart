import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Get extends ChangeNotifier {
  Future getData(String collection,String categoryid) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).where('categoryid',isEqualTo:categoryid).get();
    return snapshot.docs;
  }
  Future fetchData(String collection,) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.docs;
  }
}