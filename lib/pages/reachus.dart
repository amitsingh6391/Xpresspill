import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';

import 'package:Xpresspill/main.dart';

import '../authservice/login.dart';

class Reachus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width; //here we difine screen size
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
            child: width > 400
                ? Column(
                    children: [
                      Container(
                        width: size.width * 1,
                        decoration: BoxDecoration(color: Color(0x363A3A3B)),
                        child: Center(
                            child: Column(children: [
                          EasyRichText("LET US HELP YOU ! ",
                              patternList: [
                                EasyRichTextPattern(
                                  targetString: 'HELP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35),
                                ),
                              ],
                              defaultStyle: TextStyle(
                                  fontSize: 35,
                                  height: 2.5,
                                  color: Color(0xFF000000))),
                          EasyRichText(
                              "WE BUILD THE PHARMACY\n       THE WAY YOU\n         WANTED !",
                              patternList: [
                                EasyRichTextPattern(
                                  targetString: 'PHARMACY',
                                  //  stringBeforeTarget: 'Of',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                              defaultStyle: TextStyle(
                                  fontSize: 15,
                                  height: 2.5,
                                  color: Color(0xFF000000))),
                        ])),
                      ),
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
                                child: Text(" ©Xpresspill.ca",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                              ),
                            ),
                          ]))
                    ],
                  )
                : Column(children: [Text("MobileView")])));
  }
}
