import 'dart:io';

import 'package:Xpresspill/pages/reachus.dart';
import 'package:flutter/material.dart';

import "package:Xpresspill/authservice/signup.dart";
import "package:Xpresspill/authservice/login.dart";

import 'package:easy_rich_text/easy_rich_text.dart';

//https://pillway.com/home
//https://wwww.pocketpills.com
//https://medly.com/en-us

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpresspill-A pharmacy that comes to you',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width; //here we difine screen size
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("YES"),
                      onPressed: () {
                        exit(0);
                      },
                    ),
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height *
                  0.27), //here we define our app bar inside app bar we have  row
              child: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                    color: Color(0xFF000000),
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
          body: SingleChildScrollView(
              child: Column(children: [
            width > 400
                ? Column(
                    children: [
                      Container(
                          height: size.height * 0.75,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                            color: Color(0xFA0F0D11),
                            //color: Color(0xFA0D0F01),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    AssetImage("images/expresspilllogo.jpg"),
                              ),
                            ),
                            SizedBox(width: 150),
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
                            Text(" A pharmacy that comes to you ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green)),
                            SizedBox(width: 150),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Best Way To Improve Your Compliance For Multiple Medications In a Single Dose Pouch System ",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            SizedBox(width: 150),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" HASSLE FREE & NO EXTRA CHARGES ",
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ])),
                      Container(
                          color: Color(0x363A3A3B),
                          width: size.width * 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  " About Us",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFA0D0F01)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Row(children: [
                                  Container(
                                      width: size.width * 0.6,
                                      margin: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Color(0x363A3A3B),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0x363A3A3B),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3))
                                          ]),
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(28.0),
                                          child: EasyRichText(
                                              "We Are Community Focused Pharmacy Professionals With Years Of Community Experience.\nNow Presents You Xpress Pill, An Advanced Pharmacy System That was Never Experienced Before.\nWe Know You & Needs Better. Your Throughout Unconditional supports have Encourgaed Us To Develop A Fully Advanced Pharmacy, Integrated With Other HealthCare Services To Provide You Incredible Digital Experience that Saves Your Time & Money Both. Xpress Pill Is Proved To Be The Best Suit For All Age Groups, Whether You Are a Student, Working Proffessional , Young Parents, Retired Person Or Senior Citizen. Xpress Pill Gives You Access To Pharmacy, Virtual Doctors, Nurses, Dieticians In A Click Away Technology For  7  Days A Week From AnyWhere Any Time . ",
                                              patternList: [
                                                EasyRichTextPattern(
                                                  targetString: 'Community',
                                                  stringBeforeTarget: 'Of',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                EasyRichTextPattern(
                                                  targetString: 'Xpress',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.red),
                                                ),
                                                EasyRichTextPattern(
                                                  targetString: 'Pill',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                      color: Colors.blue),
                                                ),
                                              ],
                                              defaultStyle: TextStyle(
                                                  fontSize: 15,
                                                  height: 2.5,
                                                  color: Colors.black)),
                                        ),
                                      ])),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: CircleAvatar(
                                      radius: 150,
                                      backgroundImage:
                                          AssetImage("images/doctor.jpg"),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          )),
                      Container(
                          height: size.height * 0.8,
                          width: size.width * 1,
                          decoration: BoxDecoration(color: Colors.black),
                          child: Column(children: [
                            EasyRichText("Contact  Us ",
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: 'Us',
                                    //  stringBeforeTarget: 'Of',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35),
                                  ),
                                ],
                                defaultStyle: TextStyle(
                                    fontSize: 35,
                                    height: 2.5,
                                    color: Colors.white)),
                            Row(children: [
                              //inside row we are define our appname

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("  Xpress",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFA93226))),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text("Pill",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                              ),
                            ]),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("     3530 Sohmon Pkwy  ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Brock District, Thorold",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("   Niagara Region , ON  ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("       L2V  4Y6",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white)),
                                  ),
                                ])),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" CALL US TODAY",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" 905-209-999 ",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" 1866-966-866",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(" ©XpressPill.ca",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ),
                            ),
                          ]))
                    ],
                  )
                : Container(
                    child: Column(
                    children: [
                      Container(
                          height: size.height * 0.4,
                          decoration: BoxDecoration(color: Color(0xFFFE9A9A)),
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
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("       EXPRESS",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text("PILL",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                  )
                                ],
                              ),
                            ),
                            Text("THE EASIEST WAY TO MANAGE YOUR MEDICATIONS",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ])),
                      Container(
                        height: size.height * 0.465,
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(10),
                        //     boxShadow: [
                        //       BoxShadow(
                        //           color: Colors.grey.withOpacity(0.5),
                        //           spreadRadius: 5,
                        //           blurRadius: 7,
                        //           offset: Offset(0, 3))
                        //     ]),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("Login",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
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
                                  // controller: loginnumber,
                                  decoration: InputDecoration(
                                      hintText: "Enter Email Id.              ",
                                      hintStyle: TextStyle(
                                        decoration: TextDecoration.underline,
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
                                  // controller: loginpassword,
                                  decoration: InputDecoration(
                                      hintText:
                                          " Enter your Password             ",
                                      hintStyle: TextStyle(
                                          decoration: TextDecoration.underline),
                                      labelStyle: TextStyle(
                                          decoration: TextDecoration.underline),
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
                                          decoration: TextDecoration.underline),
                                    ),
                                  ))
                            ])
                          ],
                        ),
                      )
                    ],
                  ))
          ])),
        ));
  }
}
