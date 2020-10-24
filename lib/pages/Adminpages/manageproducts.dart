import 'package:Xpresspill/pages/Adminpages/addproducts.dart';
import 'package:Xpresspill/pages/Adminpages/editproduct.dart';
import 'package:Xpresspill/pages/Adminpages/manageusers.dart';
import "package:flutter/material.dart";

import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/firebaseserices/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import "package:flutter/material.dart";

class Manageproduct extends StatefulWidget {
  @override
  _ManageproductState createState() => _ManageproductState();
}

class _ManageproductState extends State<Manageproduct> {
  var x;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.2),
            child: Container(
                color: primaryColor,
                child: Column(
                  children: [
                    AppBar(
                      title: Text("Manage Product", style: whitetextstyle),
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
                                          builder: (context) => Manageusers()));
                                },
                                child: Text(
                                  " 👥 Manage  Users   ",
                                  style: secondtextstyle,
                                ),
                              ),
                            )),
                      )
                    ])
                  ],
                ))),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: snapshot.data.documents.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Container(
                                  // color: Colors.blue,
                                  height: size.height * 0.4,
                                  width: size.width * 0.3,
                                  child: Image(
                                      image: NetworkImage(snapshot
                                          .data.documents[index]
                                          .data()["mediaUrl"]),
                                      fit: BoxFit.fill)),
                            ),
                            Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    snapshot.data.documents[index]
                                        .data()["productName"],
                                    textAlign: TextAlign.left,
                                    style: firsttextstyle),
                              ),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Price:  ",
                                    style: firsttextstyle,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Icon(Icons.attach_money,
                                    size: 30, color: Colors.black),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data.documents[index]
                                        .data()["productPrice"]
                                        .toString(),
                                    style: secondtextstyle,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ]),
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Quantity Left : ",
                                    style: firsttextstyle,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data.documents[index]
                                          .data()["productQuantity"]
                                          .toString(),
                                      style: secondtextstyle),
                                )
                              ]),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  snapshot.data.documents[index]
                                      .data()["productDescription"],
                                ),
                              )
                            ]),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Editproduct(
                                            docid: snapshot
                                                .data.documents[index]
                                                .data()["productId"],
                                            imgurl: snapshot
                                                .data.documents[index]
                                                .data()["mediaUrl"])));
                              },
                              child: Center(
                                  child: Icon(
                                Icons.edit,
                              )),
                            )
                          ]);
                        });
                  })
            ],
          ),
        ));
  }
}
