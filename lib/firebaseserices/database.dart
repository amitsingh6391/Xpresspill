import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  searchByName() {
    return FirebaseFirestore.instance
        .collection("users")
        //.where('firsName', isEqualTo: "amit")
        .get();
  }
}
