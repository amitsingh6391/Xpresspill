import 'package:Xpresspill/authservice/auth.dart';
import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/firebaseserices/database.dart';
import 'package:Xpresspill/pages/Adminpages/manageusers.dart';
import 'package:Xpresspill/pages/addprescrption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:Xpresspill/main.dart";

String userid;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  IconData w = Icons.local_hospital;
  IconData x = Icons.post_add_outlined;
  IconData y = Icons.question_answer;
  IconData z = Icons.shopping_basket_outlined;

  getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    print("yes");
    print(uid);
    setState(() {
      userid = uid.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.12),
          child: AppBar(
            leading:Text(""),
            title: Text("DashBoard", style: whitetextstyle),
            backgroundColor: primaryColor,
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                //AuthProvider.logOut(context);
                 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage()));
                },
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                box(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyContainer("Transfer your Refills", context, w),
                ),
                box(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyContainer("Upload a Prescription", context, x),
                ),
              ]),
            ),
            box(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  box(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyContainer("Talk to a doctor", context, y)),
                  box(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyContainer("E-Commerce", context, z),
                  ),
                ],
              ),
            ),
            box(),
          ])),
        ));
  }
}

Container MyContainer(String branch, context, IconData m) {
  return Container(
    padding: EdgeInsets.all(20),
    height: MediaQuery.of(context).size.height * 0.4,
    width: MediaQuery.of(context).size.width * 0.45,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3))
        ]),
    child: GestureDetector(
      onTap: () {
        if (branch == "Upload a Prescription") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Addprescrption(userid: userid)));
        } else if (branch == "Civil") {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Civilyear()));
        } else if (branch == "Mechnical") {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Mechnicalyear()));
        } else {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Homepage()));
        }
      },
      child: Center(
          child: Column(children: [
        Icon(m, size: 80, color: Colors.black),
        Text(branch,
            style: TextStyle(
              fontFamily: "Dancing",
              fontSize: 30,
              color: Colors.black,
            )),
      ])),
    ),
  );
}

SizedBox box() {
  return SizedBox(
    height: 20,
    width: 20,
  );
}
