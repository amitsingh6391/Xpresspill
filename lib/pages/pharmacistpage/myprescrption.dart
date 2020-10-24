import 'package:Xpresspill/widget/prescrptionresult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/models/prescrption.dart';
//import 'package:Xpresspill/pages/home.dart';
//import 'package:Xpresspill/services/userService.dart';
//import 'package:Xpresspill/widgets/prescriptionResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyPrescriptions extends StatefulWidget {
  @override
  _MyPrescriptionsState createState() => _MyPrescriptionsState();
}

class _MyPrescriptionsState extends State<MyPrescriptions> {
  Stream<QuerySnapshot> _allPrescriptions;
  // UserService _userService = new UserService();
  String currentUserId;

  @override
  void initState() {
    _getCurrentUserId();

    super.initState();
  }

  _getCurrentUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = preferences.getString("userId");
    });
    print(currentUserId);
    var prescriptions = FirebaseFirestore.instance
        .collection("prescriptions")
        .where("lockedBy", isEqualTo: currentUserId)
        .snapshots();
    setState(() {
      _allPrescriptions = prescriptions;
    });
  }

  StreamBuilder buildPrescriptionResults() {
    return StreamBuilder(
      stream: _allPrescriptions,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
//        List<PrescriptionResult> searchResults=[];
//        snapshot.data.documents.forEach((doc){
//          Prescription prescription=Prescription.fromDocument(doc);
//          PrescriptionResult searchResult=PrescriptionResult(prescription);
//          searchResults.add(searchResult);
//        });

        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              Prescription prescription =
                  Prescription.fromDocument(snapshot.data.documents[index]);
              return PrescriptionResult(prescription, currentUserId);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Prescriptions"),
        backgroundColor: primaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(AntDesign.logout),
            onPressed: () {
              //   _userService.logOut(context);
            },
          )
        ],
      ),
      body: _allPrescriptions == null
          ? Center(child: CircularProgressIndicator())
          : buildPrescriptionResults(),
      // drawer: userDetailsDrawer(context: context),
    );
  }
}
