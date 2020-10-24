import 'package:Xpresspill/authservice/auth.dart';
import 'package:Xpresspill/authservice/login.dart';
import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/main.dart';
import 'package:Xpresspill/pages/homepgae.dart';
import 'package:Xpresspill/pages/reachus.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signuppage extends StatefulWidget {
  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();

  TextEditingController phone = TextEditingController();

  var dob;

  bool isloading = false;

  final signupkey = new GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  String userid;

  signup() async {
    if (signupkey.currentState.validate()) {
      setState(() {
        isloading = true;
      });

      await AuthProvider()
          .signupWithEmail(email.text, password.text)
          .then((value) async {
        if (value != null) {
          print("value hii -------> $value");
          getCurrentUser();
        } else {
          showMessage();
        }
      });
    }
  }

  getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    print(uid);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('logedin', user.uid);
    setState(() {
      userid = uid.toString();
    });

    addnewuserprofile();
  }

  addnewuserprofile() async {
    await FirebaseFirestore.instance.collection("users").doc(userid).set({
      "firstName": firstname.text,
      "lastName": lastname.text,
      "email": email.text,
      "contactNumber": phone.text,
      "dob": dob,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      "isPharmacist": false,
      "isAdmin": false,
      "id": userid
    });

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Homepage()));
    setState(() {
      isloading = false;
    });
    showsuccess();
  }

  showsuccess() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Success"),
            content: Text("Your Account is Successfully Created"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text("ok"),
              )
            ],
          );
        });
  }

  showMessage() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Error"),
            content: Text("Please Enter valid details"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Dismiss"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height *
                0.27), //here we define our app bar inside app bar we have  row
            child: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  // color: Color(0xFF000000),
                  color: primaryColor,
                  child: Column(children: [
                    EasyRichText("Xpress Pill ",
                        patternList: [
                          EasyRichTextPattern(
                            targetString: 'Pill',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 35),
                          ),
                        ],
                        defaultStyle: TextStyle(
                            fontSize: 35,
                            height: 2.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFA93226))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" 🟡  Home",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Loginpage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" 🟡  Create Account",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Loginpage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" 🟡 Download Our App",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Loginpage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" 🟡  Speak To an Advisor",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reachus()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" 🟡  Reach Us",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Loginpage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" 🟡  FAQ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ]),
                    )
                  ]),
                ))),
        body: isloading
            ? Center(
                child:
                    CircularProgressIndicator(backgroundColor: Colors.yellow))
            : SingleChildScrollView(
                child: Column(children: [
                width > 400
                    ? Container(
                        //color: Color(0xFA0F0D11),
                        color: primaryColor,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 28.0, left: 50, right: 50),
                              child: Form(
                                  key: signupkey,
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Text("Sign UP",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        Expanded(
                                          child: TextFormField(
                                            style:
                                                TextStyle(color: Colors.yellow),
                                            controller: firstname,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.person,
                                                  color: Colors.white),
                                              hintText:
                                                  "First Name             ",
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            validator: (val) {
                                              return val.length > 2
                                                  ? null
                                                  : "Enter Valid First Name";
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 100),
                                        Expanded(
                                          child: TextFormField(
                                            style:
                                                TextStyle(color: Colors.yellow),
                                            controller: lastname,
                                            decoration: InputDecoration(
                                              hintText: "Last Name           ",
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            validator: (val) {
                                              return val.length > 2
                                                  ? null
                                                  : "Enter Valid First Name";
                                            },
                                          ),
                                        )
                                      ]),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        "Select your DOB",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                          width: size.width * 0.3,
                                          height: 100,
                                          child: CupertinoDatePicker(
                                              backgroundColor: Colors.white,
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              initialDateTime:
                                                  DateTime(1997, 1, 1),
                                              onDateTimeChanged:
                                                  (DateTime newDateTime) {
                                                print(newDateTime.toString());
                                                dob = newDateTime.toString();
                                              })),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Container(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: email,
                                              decoration: InputDecoration(
                                                icon: Icon(Icons.email,
                                                    color: Colors.white),
                                                hintText: "Email          ",
                                                hintStyle: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              style: TextStyle(
                                                color: Colors.yellow,
                                              ),
                                              validator: (val) {
                                                return RegExp(
                                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(val)
                                                    ? null
                                                    : "Please Enter Valid Email";
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 100),
                                          Expanded(
                                            child: TextFormField(
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                ),
                                                controller: password,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  hintText: "Password   ",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  icon: Icon(
                                                      Icons.remove_red_eye,
                                                      color: Colors.white),
                                                ),
                                                validator: (val) {
                                                  return val.length > 4
                                                      ? null
                                                      : "Enter minimum 4 words password";
                                                }),
                                          )
                                        ]),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Container(
                                        width: 400,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(18.0),
                                            child: TextFormField(
                                                controller: phone,
                                                decoration: InputDecoration(
                                                    hintText: "Mobile .",
                                                    hintStyle: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    icon: Icon(
                                                        Icons.mobile_friendly,
                                                        color: Colors.white)),
                                                style: TextStyle(
                                                    color: Colors.yellow),
                                                validator: (val) {
                                                  return val.length > 9
                                                      ? null
                                                      : "Enter Valid Mobile number";
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () async {
                                        signup();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(28.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.arrow_forward,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ])),
                            ),
                            Container(
                              // color: Colors.black,
                              color: primaryColor,
                              width: size.width * 1,
                              height: size.height * 0.2,
                            )
                          ],
                        ))
                    : Container(
                        child: Column(
                          children: [
                            Container(
                                height: size.height * 0.4,
                                decoration:
                                    BoxDecoration(color: Color(0xFFFE9A9A)),
                                child: Column(children: [
                                  CircleAvatar(
                                    radius: 100,
                                    backgroundImage: AssetImage(
                                        "images/expresspilllogo.jpg"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text("       EXPRESS",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text("PILL",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                      "THE EASIEST WAY TO MANAGE YOUR MEDICATIONS",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ])),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    // height: size.height * 0.3,
                                    // decoration: BoxDecoration(color: Color(0xFFFE9A9A)),
                                    child: Column(
                                  children: [
                                    Container(
                                      //  height: size.height * 0.33,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3))
                                          ]),
                                      child: Column(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text("Create New Account",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(height: size.height * 0.03),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            // SizedBox(width: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 8,
                                                  bottom: 8,
                                                  right: 6),
                                              child: Icon(Icons.mail),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: email,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Enter Email Id.              ",
                                                    hintStyle: TextStyle(
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                    border: InputBorder.none),
                                                validator: (val) {
                                                  return val.length == 10
                                                      ? null
                                                      : "Enter valid Email id";
                                                },
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 8,
                                                  bottom: 8,
                                                  right: 6),
                                              child: Icon(Icons.lock),
                                            ),
                                            //  SizedBox(width: 10),
                                            Expanded(
                                              child: TextFormField(
                                                controller: password,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        " Enter your Password             ",
                                                    hintStyle: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    labelStyle: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    border: InputBorder.none),
                                                validator: (val) {
                                                  return val.length > 3
                                                      ? null
                                                      : "Enter valid password";
                                                },
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  top: 8,
                                                  bottom: 8,
                                                  right: 6),
                                              child:
                                                  Icon(Icons.mobile_friendly),
                                            ),
                                            //  SizedBox(width: 10),
                                            Expanded(
                                              child: TextFormField(
                                                controller: password,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        " Enter your Phone no.            ",
                                                    hintStyle: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    labelStyle: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    border: InputBorder.none),
                                                validator: (val) {
                                                  return val.length > 3
                                                      ? null
                                                      : "Enter valid phone no.";
                                                },
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Select your DOB"),
                                        ),
                                        Container(
                                            height: 100,
                                            child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .date,
                                                initialDateTime:
                                                    DateTime(1997, 1, 1),
                                                onDateTimeChanged:
                                                    (DateTime newDateTime) {
                                                  print(newDateTime.toString());
                                                })),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 28.0),
                                      child: Container(
                                        // color:Colors.red,
                                        //height: size.height * 0.2,
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              SizedBox(
                                                  width: size.width * 0.17),
                                              Text(
                                                  "Allready have an Account:  ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              GestureDetector(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => Step1()));
                                                  },
                                                  child: Container(
                                                    //width: size.width * 0.4,
                                                    child: Text(
                                                      "Login ",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                    ),
                                                  ))
                                            ])
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.arrow_forward),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))),
                          ],
                        ),
                      )
              ])));
  }
}
