import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/models/prescrption.dart';
import 'package:Xpresspill/pages/pharmacistpage/myprescrption.dart';
import 'package:Xpresspill/pages/pharmacistpage/myprescrption.dart';
import 'package:Xpresspill/widget/prescrptionresult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Allprescrptionpage extends StatefulWidget {
  @override
  _AllprescrptionpageState createState() => _AllprescrptionpageState();
}

class _AllprescrptionpageState extends State<Allprescrptionpage> {
  Stream<QuerySnapshot> allPrescriptions;
  String currentUserId;
  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
    var prescriptions = FirebaseFirestore.instance
        .collection("prescriptions")
        .where("isLocked", isEqualTo: false)
        .snapshots();
    setState(() {
      allPrescriptions = prescriptions;
    });
    super.initState();
  }

  _getCurrentUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = preferences.getString("logedin");
    });
  }

  StreamBuilder buildPrescriptionResults() {
    return StreamBuilder(
      stream: allPrescriptions,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text("All prescrption ")),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.2),
          child: Container(
              color: primaryColor,
              child: Column(
                children: [
                  AppBar(
                    title: Text("Manage  Prescription", style: whitetextstyle),
                    backgroundColor: primaryColor,
                    centerTitle: true,
                  ),
                  Row(children: [
                    //Icon(Icons.badge, size: 50),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor3,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyPrescriptions()));
                              },
                              child: Text(
                                " 👥 My  Prescription ",
                                style: secondtextstyle,
                              ),
                            ),
                          )),
                    )
                  ])
                ],
              ))),
      body: allPrescriptions == null
          ? Column(children: [
              Center(child: CircularProgressIndicator()),
              Text("No Prescrption Upload")
            ])
          : buildPrescriptionResults(),
    );
  }
}

/*

1 screen 
read nane,code--app>version api
read tokenID, IMEI1,IMEI2--->login




*/

//http://webster.wonsoft.co.in/API/Post.asmx
