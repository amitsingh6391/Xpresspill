//loginpage

import 'package:Xpresspill/authservice/auth.dart';
import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/main.dart';

import 'package:Xpresspill/pages/reachus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

import "package:Xpresspill/authservice/signup.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController
      loginemail = // this is controller for chek whats the user input in loginnumber
      TextEditingController(); //we will take loginnumber
  TextEditingController loginpassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool isAdmin, isPharmacist;

  @override
  void initState() {
    //getusertype();

    super.initState();

    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  signin() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
        print("yes");
      });

      bool res = await AuthProvider()
          .signInWithEmail(loginemail.text, loginpassword.text);
      if (!res) {
        print("Login failed");
        setState(() {
          isLoading = false;
          print("yes");
        });

        showMessage();
      } else {
        User user = FirebaseAuth.instance.currentUser;
        final uid = user.uid;
        print(uid);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('logedin', user.uid);
        setState(() {
          isLoading = false;
          print("yes");
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    } else {
      setState(() {
        isLoading = false;
        print("yes");
      });
      showMessage();
    }
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
            content: Text("Please Enter Corect Email or Password"),
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
    var width = MediaQuery.of(context).size.width; //here we difine screen size
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        // backgroundColor: Color(0xFF000000),
        backgroundColor: primaryColor,
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
        body: isLoading
            ? Center(
                child:
                    CircularProgressIndicator(backgroundColor: Colors.yellow))
            : Column(children: [
                width > 400
                    ? Container(
                        color: Color(0xFA0F0D11),
                        //height: size.height * 1,
                        width: size.width * 1,
                        child: Column(
                          children: [
                            Container(
                              //color: Color(0xFA0F0D11),
                              color: primaryColor,
                              child: Form(
                                key: formKey,
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Text("Login",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  Row(children: [
                                    SizedBox(width: size.width * 0.4),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style:
                                              TextStyle(color: Colors.yellow),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: loginemail,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.mail,
                                                  color: Colors.white),
                                              hintText:
                                                  "Enter Email Id.                   ",
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              border: InputBorder.none),
                                          validator: (val) {
                                            return RegExp(
                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                    .hasMatch(val)
                                                ? null
                                                : "Please Enter Valid Email";
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                                  Row(children: [
                                    SizedBox(width: size.width * 0.4),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          style:
                                              TextStyle(color: Colors.yellow),
                                          obscureText: true,
                                          controller: loginpassword,
                                          decoration: InputDecoration(
                                              icon: Icon(Icons.lock,
                                                  color: Colors.white),
                                              hintText:
                                                  " Enter your Password             ",
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.underline),
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.underline),
                                              counterStyle: TextStyle(
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.underline),
                                              border: InputBorder.none),
                                          validator: (val) {
                                            return val.length > 3
                                                ? null
                                                : "Enter valid password";
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                                  logedin != null
                                      ? StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(logedin)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container(
                                                  color: primaryColor,
                                                  child: Text("",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black)));
                                            }

                                            var Profiledetail = snapshot.data;
                                            isAdmin = Profiledetail["isAdmin"];
                                            isPharmacist =
                                                Profiledetail["isPharmacist"];

                                            return Container(
                                                color: primaryColor,
                                                child: Text("",
                                                    style: TextStyle(
                                                        color: Colors.black)));
                                          },
                                        )
                                      : Text(""),
                                  FlatButton(
                                    onPressed: () {
                                      signin();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
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
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          SizedBox(width: size.width * 0.4),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "Don't Have an Account:  ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.yellow,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          FlatButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Signuppage()));
                                              },
                                              child: Container(
                                                //width: size.width * 0.4,
                                                child: Text(
                                                  "Register",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              ))
                                        ])
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ),
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
                                  backgroundImage:
                                      AssetImage("images/expresspilllogo.jpg"),
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
                          Container(
                            height: size.height * 0.465,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(height: size.height * 0.03),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  // SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8, bottom: 8, right: 6),
                                    child: Icon(Icons.mail),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: loginemail,
                                      decoration: InputDecoration(
                                          hintText:
                                              "Enter Email Id.              ",
                                          hintStyle: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
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
                                        left: 8.0, top: 8, bottom: 8, right: 6),
                                    child: Icon(Icons.lock),
                                  ),
                                  //  SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller: loginpassword,
                                      decoration: InputDecoration(
                                          hintText:
                                              " Enter your Password             ",
                                          hintStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline),
                                          labelStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline),
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
                            ]),
                          ),
                          Container(
                            // color:Colors.red,
                            height: size.height * 0.2,
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: size.height * 0.06,
                                // ),
                                Row(children: [
                                  SizedBox(width: size.width * 0.17),
                                  Text("Don't Have an Account:  ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Signuppage()));
                                      },
                                      child: Container(
                                        //width: size.width * 0.4,
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ))
                                ])
                              ],
                            ),
                          )
                        ],
                      ))
              ]));
  }
}
