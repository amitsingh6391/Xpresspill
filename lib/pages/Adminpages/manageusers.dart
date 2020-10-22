import 'package:Xpresspill/main.dart';
import 'package:Xpresspill/pages/Adminpages/addproducts.dart';
import 'package:Xpresspill/pages/Adminpages/manageproducts.dart';
import "package:flutter/material.dart";

import 'package:Xpresspill/authservice/auth.dart';
import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/firebaseserices/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Manageusers extends StatefulWidget {
  @override
  _ManageusersState createState() => _ManageusersState();
}

class _ManageusersState extends State<Manageusers> {
  Stream allUsers;
  AuthProvider userService = AuthProvider();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot listofusers;
  bool haveUserSearched = false;
  @override
  void initState() {
    super.initState();
  }

  showMessage(String userid) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Alert !"),
            content: Text("Change a new Status."),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Manageusers()));
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(userid)
                      .update({"isPharmacist": false});
                },
                child: Text("User"),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Manageusers()));
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(userid)
                      .update({"isPharmacist": true});
                },
                child: Text("Pharmacist"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Manageusers()));
                },
                child: Text("Cancel"),
              )
            ],
          );
        });
  }

  Widget userTile(
      String firstname, String lastname, String userid, bool isPharmacist) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(radius: 30, child: Icon(Icons.person)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "$firstname $lastname",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  isPharmacist
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Pharmacist",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "User",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        )
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showMessage(userid);
                },
                child: Center(
                    child: Icon(
                  Icons.edit,
                )),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FlatButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Addproducts()));
          },
          child: Padding(
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
                  child: Text(" +  Add Product", style: firsttextstyle),
                )),
          ),
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.2),
            child: Container(
                color: primaryColor,
                child: Column(
                  children: [
                    AppBar(
                      title: Text("Manage Users", style: whitetextstyle),
                      backgroundColor: primaryColor,
                      centerTitle: true,
                      actions: [
                        IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            // AuthProvider.logOut(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Manageproduct()));
                          },
                        )
                      ],
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
                                              Manageproduct()));
                                },
                                child: Text(
                                  " 👝 Manage Products",
                                  style: secondtextstyle,
                                ),
                              ),
                            )),
                      )
                    ])
                  ],
                ))),
        body: SingleChildScrollView(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where('isAdmin', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator(
                backgroundColor: Colors.red,
              );
            }
            return ListView.builder(
                reverse: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return userTile(
                      snapshot.data.documents[index].data()['firstName'],
                      snapshot.data.documents[index].data()["lastName"],
                      snapshot.data.documents[index].data()["id"],
                      snapshot.data.documents[index].data()["isPharmacist"]);
                });
          },
        )));
  }
}
