import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:survey_app/utlis/constants.dart';
import 'package:survey_app/widgets/historyBox.dart';

import 'package:survey_app/screens/particularHistorySurvey.dart';

import 'package:survey_app/utlis/app_icon.dart';
import 'package:survey_app/widgets/drawer.dart';
import 'package:survey_app/widgets/top_right_widget.dart';
import 'package:time_elapsed/time_elapsed.dart';

import 'phqtest_graphscreen.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> surveyHistory = [];
  List<dynamic> revSurveyHistory = [];
  List<dynamic> datesWhenTestTake = [];
  List<dynamic> datesscore = [];
  List<dynamic> datestime = [];

  bool dateSelected = false;
  bool reverse = false;
  var rawData;
  int year = 2021;
  int day = 1;
  int previousIndex = -1;
  List expandableBool = [];

  int datePreviousIndex;

  int month = 1;
  int index = 1;
  String monthVal = "January";
  var varDate = DateTime.now();
  var weeklySelected = true;
  final _controller = ScrollController();

  var totalDate = DateFormat.yMMMMd('en_US').format(DateTime.now());

  var reversedList = [];

  List<DateTime> days = [];
  List<bool> daysBool = [];
  var viewAnswerColor = false;

  getData() async {
    var data = await FlutterSecureStorage().read(key: 'history');
    setState(() {
      var dumData = jsonDecode(data);
      for (int i = 0; i < dumData.length; i++) {
        surveyHistory.add(dumData[i]);
      }

      print("this is my suryvey history $surveyHistory");
    });
    for (int i = 0; i < surveyHistory.length; i++) {
      var date = surveyHistory[i][1];
      var time = surveyHistory[i][0];
      var score = surveyHistory[i][3];
      print(date);
      setState(() {
        datestime.add(time);
        datesWhenTestTake.add(date);
        datesscore.add(score);
        expandableBool.add(false);
      });
    }

    print(
        "Date : $datesWhenTestTake  and time:  $datestime  and score :  $datesscore");
  }

  List<DateTime> getDaysInBeteween() {
    print("getDaysInBetween");
    DateTime endDate = DateTime.now().toLocal();
    DateTime startDate = DateTime(2021);

    print(startDate);
    print(endDate);

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      setState(() {
        days.add(startDate.add(Duration(days: i)));
        daysBool.add(false);
      });
    }
    setState(() {
      datePreviousIndex = daysBool.length - 1;
      daysBool[datePreviousIndex] = true;
    });
    print(days);
    return days;
  }

  @override
  void initState() {
    super.initState();
    setDateData();
    getData();

    getDaysInBeteween();
  }

  Future function(index) {
    print('function called');
    print(index);
    setState(() {
      if (previousIndex == index && index >= 0) {
        expandableBool[index] = false;
        previousIndex = -1;
      } else {
        expandableBool[index] = true;
        if (previousIndex >= 0 && previousIndex != index)
          expandableBool[previousIndex] = false;
        previousIndex = index;
      }

      print(expandableBool);
    });
  }

  String monthStringValue =
      DateTime.now().toLocal().toString().split('-')[1].toString();
  var skipDays = 0;

  _getMonth({String monthText, int monthInt, String monthValue}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: month == monthInt
          ? BoxDecoration(
              color: Color.fromRGBO(119, 131, 143, 1),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  month = monthInt;
                  monthVal = monthValue;
                  if (month == 1) {
                    monthStringValue = "01";
                  } else if (month == 2) {
                    monthStringValue = "02";
                  } else if (month == 3) {
                    monthStringValue = "03";
                  } else if (month == 4) {
                    monthStringValue = "04";
                  } else if (month == 5) {
                    monthStringValue = "05";
                  } else if (month == 6) {
                    monthStringValue = "06";
                  } else if (month == 7) {
                    monthStringValue = "07";
                  } else if (month == 8) {
                    monthStringValue = "08";
                  } else if (month == 9) {
                    monthStringValue = "09";
                  } else if (month == 10) {
                    monthStringValue = "10";
                  } else if (month == 11) {
                    monthStringValue = "11";
                  } else if (month == 12) {
                    monthStringValue = "12";
                  }
                  var firstDate = year.toString() + monthStringValue + "01";
                  var dateIs = DateTime.parse(firstDate);
                  var firstDay = DateFormat('EEEE').format(dateIs);
                  skipDays = _weekDaysFull.indexOf(firstDay);

                  totalDate =
                      monthVal + " " + day.toString() + ", " + year.toString();
                });
              },
              child: Text(
                '$monthText',
                style: TextStyle(
                    fontFamily: fontSemi,
                    color: month == monthInt ? Colors.white : Colors.black),
              ),
            ),
            datesWhenTestTake.toString().contains(monthValue)
                ? Icon(
                    Icons.circle,
                    color: blue,
                    size: 10,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  bool IsLeapYear(int year) {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  bool shouldHideDay() {
    if (month == 1) {
      return false;
    } else if (month == 2) {
      return true;
    } else if (month == 3) {
      return false;
    } else if (month == 4) {
      return true;
    } else if (month == 5) {
      return false;
    } else if (month == 6) {
      return true;
    } else if (month == 7) {
      return false;
    } else if (month == 8) {
      return false;
    } else if (month == 9) {
      return true;
    } else if (month == 10) {
      return false;
    } else if (month == 11) {
      return true;
    } else if (month == 12) {
      return false;
    }
  }

  var isSorting = false;

  Widget _listOfResults(hist, totDate, checkDate) {
    List<Widget> list = [];
    if (checkDate == true) {
      for (int i = 0; i < surveyHistory.length; i++) {
        var time = surveyHistory[i][0];
        var date = surveyHistory[i][1];

        var result = surveyHistory[i][3];

        var timeStamp = surveyHistory[i][4];
        String elapsedTime = TimeElapsed().fromDateStr(timeStamp);
        elapsedTime = elapsedTime == "Now" ? "1m" : elapsedTime;
        print("|||||||||||||||||||||" + elapsedTime.toString());
        print(date);
        String text = result < 5
            ? 'It is good to see that you are taking care of yourself\n\nKeep it up :)'
            : result < 10
                ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                : result <= 15
                    ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                    : 'Your test results indicate some symptoms of depression. You are advised to seek urgent medical care promptly. Visit the ER or call 911 now.';
        if (totDate.toString() == date.toString()) {
          list.add(Padding(
            padding: const EdgeInsets.only(bottom: 18.0, right: 20),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ParticularHistory(surveyHistory[i])));
              },
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    viewAnswerColor = true;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ParticularHistory(surveyHistory[i])));
                  setState(() {
                    viewAnswerColor = false;
                  });
                },
                child: Container(
                  height: (MediaQuery.of(context).size.height / 100) * 42,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(236, 236, 236, 1),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: Color.fromRGBO(151, 151, 151, 1), //(x,y)
                          blurRadius: 0,
                          spreadRadius: 0),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height:
                            (MediaQuery.of(context).size.height / 100) * 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Test Taken - PHQ-9",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: fontRegular,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: Container(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      5,
                              width:
                                  (MediaQuery.of(context).size.height / 100) *
                                      5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: result < 5
                                          ? Colors.green
                                          : result < 10
                                              ? Colors.yellow
                                              : result <= 14
                                                  ? Colors.red.shade200
                                                  : Colors.red,
                                      width: 4)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height / 100) * 5,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Container(
                              width: double.infinity - 20,
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      24,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      color: Color.fromRGBO(
                                          151, 151, 151, 1), //(x,y)
                                      blurRadius: 6,
                                      spreadRadius: 0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12),
                                child: Text(
                                  '$text',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: fontRegular),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            (MediaQuery.of(context).size.height / 100) * 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Color.fromRGBO(82, 82, 82, 1),
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "$elapsedTime ago",
                                  style: TextStyle(
                                    fontFamily: fontRegular,
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Icon(
                                    Icons.circle,
                                    color: Color.fromRGBO(82, 82, 82, 1)
                                        .withOpacity(0.4),
                                    size: 8,
                                  ),
                                ),
                                Text(
                                  "$time",
                                  style: TextStyle(
                                    fontFamily: fontRegular,
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
        }
      }
      List<Widget> revList = list.reversed.toList();
      return reverse
          ? Column(
              children: revList,
            )
          : Column(
              children: list,
            );
    } else {
      for (int i = 0; i < hist.length; i++) {
        var time = hist[i][0];
        var date = hist[i][1];
        var surveyData = hist[i][2];
        var result = hist[i][3];
        var timeStamp = hist[i][4];
        String elapsedTime = TimeElapsed().fromDateStr(timeStamp);
        elapsedTime = elapsedTime == "Now" ? "1m" : elapsedTime;
        var text = result < 5
            ? 'It is good to see that you are taking care of yourself\n\nKeep it up :)'
            : result < 10
                ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                : result <= 15
                    ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                    : 'Your test results indicate some symptoms of depression. You are advised to seek urgent medical care promptly. Visit the ER or call 911 now.';

        list.add(Column(
          children: [
            HistorBox(time, date, surveyData, result, hist[i], i, function),
            expandableBool[i]
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ParticularHistory(hist[i])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Container(
                        height: (MediaQuery.of(context).size.height / 100) * 42,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(236, 236, 236, 1),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: Color.fromRGBO(151, 151, 151, 1), //(x,y)
                                blurRadius: 0,
                                spreadRadius: 0),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      1.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    "Test Taken - PHQ-9",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: fontRegular,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height /
                                                100) *
                                            5,
                                    width: (MediaQuery.of(context).size.height /
                                            100) *
                                        5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: result < 5
                                                ? Colors.green
                                                : result < 10
                                                    ? Colors.yellow
                                                    : result <= 14
                                                        ? Colors.red.shade200
                                                        : Colors.red,
                                            width: 4)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Container(
                                width: double.infinity - 20,
                                height:
                                    (MediaQuery.of(context).size.height / 100) *
                                        24,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Color.fromRGBO(
                                            151, 151, 151, 1), //(x,y)
                                        blurRadius: 6,
                                        spreadRadius: 0),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 12),
                                  child: Text(
                                    '$text',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: fontRegular),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      1.5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Color.fromRGBO(82, 82, 82, 1),
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "$elapsedTime ago",
                                        style: TextStyle(
                                          fontFamily: fontRegular,
                                          color: Color.fromRGBO(82, 82, 82, 1),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Icon(
                                          Icons.circle,
                                          color: Color.fromRGBO(82, 82, 82, 1)
                                              .withOpacity(0.4),
                                          size: 8,
                                        ),
                                      ),
                                      Text(
                                        "$time",
                                        style: TextStyle(
                                          fontFamily: fontRegular,
                                          color: Color.fromRGBO(82, 82, 82, 1),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ));
      }
      return Column(
        children: list,
      );
    }
  }

  _getDay({String dayText, int dayInt}) {
    print(monthVal + " " + day.toString() + ", " + year.toString());
    print(datesWhenTestTake
        .contains(monthVal + " " + day.toString() + ", " + year.toString()));
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.width * 0.122,
      decoration: day == dayInt
          ? BoxDecoration(
              color: Color.fromRGBO(119, 131, 143, 1),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                day = dayInt;
                totalDate =
                    monthVal + " " + day.toString() + ", " + year.toString();
              });
            },
            child: Text(
              '$dayText',
              style: TextStyle(
                  color: day == dayInt ? Colors.white : Colors.black,
                  fontFamily: fontSemi),
            ),
          ),
          datesWhenTestTake.contains(
                  monthVal + " " + dayInt.toString() + ", " + year.toString())
              ? Icon(
                  Icons.circle,
                  color: blue,
                  size: 10,
                )
              : Container(),
        ],
      ),
    );
  }

  setDateData() {
    setState(() {
      year = int.parse(DateTime.now().toLocal().toString().split('-')[0]);
      month = int.parse(DateTime.now().toLocal().toString().split('-')[1]);
      monthVal = currentMonth(month);
      print(DateTime.now().toLocal().toString().split('-'));
      if (month == 1) {
        monthStringValue = "01";
      } else if (month == 2) {
        monthStringValue = "02";
      } else if (month == 3) {
        monthStringValue = "03";
      } else if (month == 4) {
        monthStringValue = "04";
      } else if (month == 5) {
        monthStringValue = "05";
      } else if (month == 6) {
        monthStringValue = "06";
      } else if (month == 7) {
        monthStringValue = "07";
      } else if (month == 8) {
        monthStringValue = "08";
      } else if (month == 9) {
        monthStringValue = "09";
      } else if (month == 10) {
        monthStringValue = "10";
      } else if (month == 11) {
        monthStringValue = "11";
      } else if (month == 12) {
        monthStringValue = "12";
      }
      day = int.parse(DateTime.now()
          .toLocal()
          .toString()
          .split('-')[2]
          .toString()
          .split(" ")[0]);
      var firstDate = year.toString() + monthStringValue + "01";
      var dateIs = DateTime.parse(firstDate);
      var firstDay = DateFormat('EEEE').format(dateIs);
      skipDays = _weekDaysFull.indexOf(firstDay);
    });
  }

  final List<String> _weekDaysFull = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    'Saturday',
    "Sunday"
  ];
  final List<String> _weekDays = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN'
  ];

  Widget _weekDayTitle(int index) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        _weekDays[index],
        style: TextStyle(
            color: Color.fromRGBO(119, 131, 143, 1),
            fontSize: 11,
            fontFamily: fontRegular,
            fontWeight: FontWeight.w300),
      ),
    );
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  double iconSize = 20;
  double textSize = 18;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      endDrawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: MyDrawer(
          scaffoldKey: _scaffoldState,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.history,
          color: Colors.red,
        ),
        onPressed: () {
          debugPrint("im pressend");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhqTestGraphScreen()));
        },
      ),
      body: dateSelected
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 0),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  height: (MediaQuery.of(context).size.height /
                                          100) *
                                      21,
                                  child: Text(
                                    "Your Results",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: fontBold, fontSize: 26),
                                  ),
                                ),
                                topRightWidget(context),
                                Positioned(
                                    bottom: 0,
                                    right: 15,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                reverse = true;
                                              });
                                              print(surveyHistory);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  reverse
                                                      ? Icons
                                                          .radio_button_checked
                                                      : Icons.radio_button_off,
                                                  color: mainColor,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Latest',
                                                  style: TextStyle(
                                                      color: mainColor,
                                                      fontSize: 16,
                                                      fontFamily: fontMed),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('reversed called');
                                                //     if(surveyHistory.length >=5){
                                                reverse = false;
                                                //    }

                                                print(surveyHistory);
                                                print(reverse);
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  reverse == false
                                                      ? Icons
                                                          .radio_button_checked
                                                      : Icons.radio_button_off,
                                                  color: mainColor,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Oldest',
                                                  style: TextStyle(
                                                      color: mainColor,
                                                      fontSize: 16,
                                                      fontFamily: fontMed),
                                                )
                                              ],
                                            )),
                                      ],
                                    )),
                                Positioned(
                                  top: 30,
                                  left: 0,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          AppIcons3.icon_ionic_ios_arrow_back,
                                          size: 20,
                                        )),
                                  ),
                                ),
                                Positioned(
                                  top: 15,
                                  right: 5,
                                  child: IconButton(
                                    icon: Icon(Icons.menu,
                                        color: Colors.white, size: 26),
                                    onPressed: () {
                                      _scaffoldState.currentState
                                          .openEndDrawer();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          dateSelected = false;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            'All',
                                            style: dateSelected
                                                ? TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                    fontFamily: fontMed)
                                                : TextStyle(
                                                    color: mainColor,
                                                    fontSize: 18,
                                                    fontFamily: fontMed),
                                          ),
                                          SizedBox(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    100) *
                                                1,
                                          ),
                                          dateSelected
                                              ? Container(
                                                  height: 7,
                                                  width: 500,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black26,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      500),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      500))),
                                                )
                                              : Container(
                                                  color: Colors.black26,
                                                  child: Container(
                                                    height: 7,
                                                    width: 500,
                                                    decoration: BoxDecoration(
                                                        color: mainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(500)),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: RawMaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            dateSelected = true;
                                            weeklySelected = true;
                                            Timer(
                                              Duration(milliseconds: 100),
                                              () {
                                                _controller.animateTo(
                                                  _controller
                                                      .position.maxScrollExtent,
                                                  curve: Curves.easeOut,
                                                  duration: const Duration(
                                                      milliseconds: 50),
                                                );
                                                print("called");
                                              },
                                            );
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "Open Calendar",
                                              style: dateSelected
                                                  ? TextStyle(
                                                      color: mainColor,
                                                      fontSize: 18,
                                                      fontFamily: fontMed)
                                                  : TextStyle(
                                                      fontFamily: fontMed,
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      100) *
                                                  1,
                                            ),
                                            dateSelected
                                                ? Container(
                                                    color: Colors.black26,
                                                    child: Container(
                                                      height: 7,
                                                      width: 500,
                                                      decoration: BoxDecoration(
                                                          color: mainColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      500)),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 7,
                                                    width: 500,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black26,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        500),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        500))),
                                                  )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            dateSelected
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: weeklySelected
                                                  ? mainColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: weeklySelected
                                                  ? null
                                                  : Border.all(
                                                      width: weeklySelected
                                                          ? 0
                                                          : 0.8,
                                                      color: Colors.black)),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  weeklySelected = true;
                                                  varDate = DateTime.now();
                                                  daysBool[datePreviousIndex] =
                                                      false;
                                                  daysBool[daysBool.length -
                                                      1] = true;
                                                  datePreviousIndex =
                                                      daysBool.length - 1;
                                                  final DateFormat formatter =
                                                      DateFormat.yMMMMd(
                                                          'en_US');
                                                  final String formattedDate =
                                                      formatter.format(
                                                          DateTime.now());
                                                  print(formattedDate);
                                                  totalDate = formattedDate;

                                                  Timer(
                                                    Duration(milliseconds: 100),
                                                    () {
                                                      _controller.animateTo(
                                                        _controller.position
                                                            .maxScrollExtent,
                                                        curve: Curves.easeOut,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    50),
                                                      );
                                                      print("called");
                                                    },
                                                  );
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5),
                                                child: Text(
                                                  "Week",
                                                  style: TextStyle(
                                                    fontFamily: fontRegular,
                                                    color: weeklySelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        SizedBox(width: 12),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: weeklySelected == false
                                                  ? mainColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: weeklySelected
                                                  ? Border.all(
                                                      width: weeklySelected
                                                          ? .8
                                                          : 0,
                                                      color: Colors.black)
                                                  : null),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  totalDate = monthVal +
                                                      " " +
                                                      day.toString() +
                                                      ", " +
                                                      year.toString();
                                                  weeklySelected = false;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5),
                                                child: Text(
                                                  "Month",
                                                  style: TextStyle(
                                                    fontFamily: fontRegular,
                                                    color:
                                                        weeklySelected == false
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            dateSelected
                                ? weeklySelected
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: 18.0,
                                        ),
                                        child: Container(
                                            height: 75,
                                            child: ListView.builder(
                                              controller: _controller,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext contex,
                                                  int index) {
                                                var listDate = days[index];

                                                bool today = listDate
                                                        .toString()
                                                        .split(' ')[0] ==
                                                    DateTime.now()
                                                        .toLocal()
                                                        .toString()
                                                        .split(" ")[0];

                                                final DateFormat form =
                                                    DateFormat.yMMMMd('en_US');
                                                final String formattedDate =
                                                    form.format(listDate);
                                                print("Printing listDate" +
                                                    formattedDate.toString());
                                                print(datesWhenTestTake);
                                                var listDay = DateFormat('EEEE')
                                                    .format(listDate);
                                                print(listDay);
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12),
                                                  child: Container(
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                        color: daysBool[index]
                                                            ? blue
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            daysBool[
                                                                    datePreviousIndex] =
                                                                false;
                                                            daysBool[index] =
                                                                true;
                                                            datePreviousIndex =
                                                                index;
                                                            final DateFormat
                                                                formatter =
                                                                DateFormat
                                                                    .yMMMMd(
                                                                        'en_US');
                                                            final String
                                                                formattedDate =
                                                                formatter.format(
                                                                    listDate);
                                                            print(
                                                                formattedDate);
                                                            totalDate =
                                                                formattedDate;
                                                          });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              listDay.substring(
                                                                  0, 3),
                                                              style: TextStyle(
                                                                  color: daysBool[
                                                                          index]
                                                                      ? Colors
                                                                          .white
                                                                      : Color.fromRGBO(
                                                                          144,
                                                                          144,
                                                                          144,
                                                                          1),
                                                                  fontFamily:
                                                                      fontRegular),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            500),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            7)),
                                                                child: Text(
                                                                  "${listDate.toString().split(" ")[0].split("-")[2]}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          fontSemi),
                                                                )),
                                                            today
                                                                ? Container()
                                                                : datesWhenTestTake
                                                                            .contains(formattedDate.toString()) ==
                                                                        true
                                                                    ? Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: today
                                                                            ? mainColor
                                                                            : blue,
                                                                        size:
                                                                            10.5,
                                                                      )
                                                                    : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: days.length,
                                            )),
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_back_ios_outlined,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      year--;
                                                      var firstDate =
                                                          year.toString() +
                                                              monthStringValue +
                                                              "01";
                                                      var dateIs =
                                                          DateTime.parse(
                                                              firstDate);
                                                      var firstDay =
                                                          DateFormat('EEEE')
                                                              .format(dateIs);
                                                      skipDays = _weekDaysFull
                                                          .indexOf(firstDay);

                                                      totalDate = monthVal +
                                                          " " +
                                                          day.toString() +
                                                          ", " +
                                                          year.toString();
                                                    });
                                                  }),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18.0),
                                                child: Text(
                                                  '$year',
                                                  style: TextStyle(
                                                      fontFamily: fontBold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      year++;
                                                      var firstDate =
                                                          year.toString() +
                                                              monthStringValue +
                                                              "01";
                                                      var dateIs =
                                                          DateTime.parse(
                                                              firstDate);
                                                      var firstDay =
                                                          DateFormat('EEEE')
                                                              .format(dateIs);
                                                      skipDays = _weekDaysFull
                                                          .indexOf(firstDay);
                                                    });
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    _getMonth(
                                                        monthText: "Jan",
                                                        monthInt: 1,
                                                        monthValue: "January"),
                                                    _getMonth(
                                                        monthText: "Feb",
                                                        monthInt: 2,
                                                        monthValue: "February"),
                                                    _getMonth(
                                                        monthText: "Mar",
                                                        monthInt: 3,
                                                        monthValue: "March"),
                                                    _getMonth(
                                                        monthText: "Apr",
                                                        monthInt: 4,
                                                        monthValue: "April"),
                                                    _getMonth(
                                                        monthText: "May",
                                                        monthInt: 5,
                                                        monthValue: "May"),
                                                    _getMonth(
                                                        monthText: "Jun",
                                                        monthInt: 6,
                                                        monthValue: "June"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _getMonth(
                                                        monthText: "Jul",
                                                        monthInt: 7,
                                                        monthValue: "July"),
                                                    _getMonth(
                                                        monthText: "Aug",
                                                        monthInt: 8,
                                                        monthValue: "August"),
                                                    _getMonth(
                                                        monthText: "Sep",
                                                        monthInt: 9,
                                                        monthValue:
                                                            "September"),
                                                    _getMonth(
                                                        monthText: "Oct",
                                                        monthInt: 10,
                                                        monthValue: "October"),
                                                    _getMonth(
                                                        monthText: "Nov",
                                                        monthInt: 11,
                                                        monthValue: "November"),
                                                    _getMonth(
                                                        monthText: "Dec",
                                                        monthInt: 12,
                                                        monthValue: "December"),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    248, 248, 248, 1),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.33,
                                                child: GridView.builder(
                                                  physics: ScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemCount: 31 + 7 + skipDays,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0,
                                                    crossAxisCount: 7,
                                                    crossAxisSpacing: 20,
                                                  ),
                                                  itemBuilder: (context, i) {
                                                    if (!IsLeapYear(year) &&
                                                        month == 2 &&
                                                        i - 6 - skipDays ==
                                                            29) {
                                                      return Container();
                                                    }
                                                    if (i - 6 - skipDays ==
                                                            30 &&
                                                        month == 2) {
                                                      return Container();
                                                    }
                                                    if (i - 6 - skipDays ==
                                                            31 &&
                                                        shouldHideDay()) {
                                                      return Container();
                                                    }
                                                    if (i < 7)
                                                      return _weekDayTitle(i);
                                                    else if (i - 6 - skipDays <
                                                        1) {
                                                      return Container();
                                                    } else if (i -
                                                            6 -
                                                            skipDays <=
                                                        31) {
                                                      return _getDay(
                                                          dayInt:
                                                              i - 6 - skipDays,
                                                          dayText:
                                                              (i - 6 - skipDays)
                                                                  .toString());
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                )),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )
                                : Container(),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      1,
                            ),
                          ],
                        ),
                      ),
                      _listOfResults(surveyHistory, totalDate, true)
                    ],
                  ),
                )
              ],
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 0),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  height: (MediaQuery.of(context).size.height /
                                          100) *
                                      21,
                                  child: Text(
                                    "Your Results",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: fontBold, fontSize: 26),
                                  ),
                                ),
                                topRightWidget(context),
                                SizedBox(height: size.height * .25),
                                Positioned(
                                    bottom: 0,
                                    right: 15,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                reverse = true;
                                              });
                                              print(surveyHistory);
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  reverse
                                                      ? Icons
                                                          .radio_button_checked
                                                      : Icons.radio_button_off,
                                                  color: mainColor,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Latest',
                                                  style: TextStyle(
                                                      color: mainColor,
                                                      fontSize: 16,
                                                      fontFamily: fontMed),
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print('reversed called');
                                                //     if(surveyHistory.length >=5){
                                                reverse = false;
                                                //    }

                                                print(surveyHistory);
                                                print(reverse);
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  reverse == false
                                                      ? Icons
                                                          .radio_button_checked
                                                      : Icons.radio_button_off,
                                                  color: mainColor,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Oldest',
                                                  style: TextStyle(
                                                      color: mainColor,
                                                      fontSize: 16,
                                                      fontFamily: fontMed),
                                                )
                                              ],
                                            )),
                                      ],
                                    )),
                                Positioned(
                                  top: 30,
                                  left: 0,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: IconButton(
                                            iconSize: 20,
                                            icon: Icon(
                                              AppIcons3
                                                  .icon_ionic_ios_arrow_back,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                                Positioned(
                                  top: 15,
                                  right: 5,
                                  child: IconButton(
                                    icon: Icon(Icons.menu,
                                        color: Colors.white, size: 26),
                                    onPressed: () {
                                      _scaffoldState.currentState
                                          .openEndDrawer();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          dateSelected = false;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            'All',
                                            style: dateSelected
                                                ? TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                    fontFamily: fontMed)
                                                : TextStyle(
                                                    color: mainColor,
                                                    fontSize: 18,
                                                    fontFamily: fontMed),
                                          ),
                                          SizedBox(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    100) *
                                                1,
                                          ),
                                          dateSelected
                                              ? Container(
                                                  height: 7,
                                                  width: 500,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black26,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      500),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      500))),
                                                )
                                              : Container(
                                                  color: Colors.black26,
                                                  child: Container(
                                                    height: 7,
                                                    width: 500,
                                                    decoration: BoxDecoration(
                                                        color: mainColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(500)),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: RawMaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            dateSelected = true;
                                            weeklySelected = true;
                                            Timer(
                                              Duration(milliseconds: 100),
                                              () {
                                                _controller.animateTo(
                                                  _controller
                                                      .position.maxScrollExtent,
                                                  curve: Curves.easeOut,
                                                  duration: const Duration(
                                                      milliseconds: 50),
                                                );
                                                print("called");
                                              },
                                            );
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "Open Calendar",
                                              style: dateSelected
                                                  ? TextStyle(
                                                      color: mainColor,
                                                      fontSize: 18,
                                                      fontFamily: fontMed)
                                                  : TextStyle(
                                                      fontFamily: fontMed,
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      100) *
                                                  1,
                                            ),
                                            dateSelected
                                                ? Container(
                                                    color: Colors.black26,
                                                    child: Container(
                                                      height: 7,
                                                      width: 500,
                                                      decoration: BoxDecoration(
                                                          color: mainColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      500)),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 7,
                                                    width: 500,
                                                    decoration: BoxDecoration(
                                                        color: Colors.black26,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        500),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        500))),
                                                  )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            dateSelected
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: weeklySelected
                                                  ? mainColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: weeklySelected
                                                  ? null
                                                  : Border.all(
                                                      width: weeklySelected
                                                          ? 0
                                                          : 0.8,
                                                      color: Colors.black)),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  weeklySelected = true;
                                                  varDate = DateTime.now();
                                                  daysBool[datePreviousIndex] =
                                                      false;
                                                  daysBool[daysBool.length -
                                                      1] = true;
                                                  datePreviousIndex =
                                                      daysBool.length - 1;
                                                  final DateFormat formatter =
                                                      DateFormat.yMMMMd(
                                                          'en_US');
                                                  final String formattedDate =
                                                      formatter.format(
                                                          DateTime.now());
                                                  print(formattedDate);
                                                  totalDate = formattedDate;

                                                  Timer(
                                                    Duration(milliseconds: 100),
                                                    () {
                                                      _controller.animateTo(
                                                        _controller.position
                                                            .maxScrollExtent,
                                                        curve: Curves.easeOut,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    50),
                                                      );
                                                      print("called");
                                                    },
                                                  );
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5),
                                                child: Text(
                                                  "Week",
                                                  style: TextStyle(
                                                    fontFamily: fontRegular,
                                                    color: weeklySelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              )),
                                        ),
                                        SizedBox(width: 12),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: weeklySelected == false
                                                  ? mainColor
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: weeklySelected
                                                  ? Border.all(
                                                      width: weeklySelected
                                                          ? .8
                                                          : 0,
                                                      color: Colors.black)
                                                  : null),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  totalDate = monthVal +
                                                      " " +
                                                      day.toString() +
                                                      ", " +
                                                      year.toString();
                                                  weeklySelected = false;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 5),
                                                child: Text(
                                                  "Month",
                                                  style: TextStyle(
                                                    fontFamily: fontRegular,
                                                    color:
                                                        weeklySelected == false
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            dateSelected
                                ? weeklySelected
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: 18.0,
                                        ),
                                        child: Container(
                                            height: 75,
                                            child: ListView.builder(
                                              controller: _controller,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (BuildContext contex,
                                                  int index) {
                                                var listDate = days[index];

                                                bool today = listDate
                                                        .toString()
                                                        .split(' ')[0] ==
                                                    DateTime.now()
                                                        .toLocal()
                                                        .toString()
                                                        .split(" ")[0];

                                                final DateFormat form =
                                                    DateFormat.yMMMMd('en_US');
                                                final String formattedDate =
                                                    form.format(listDate);
                                                print("Printing listDate" +
                                                    formattedDate.toString());
                                                print(datesWhenTestTake);
                                                var listDay = DateFormat('EEEE')
                                                    .format(listDate);
                                                print(listDay);
                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12),
                                                  child: Container(
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                        color: daysBool[index]
                                                            ? blue
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    child: Center(
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            daysBool[
                                                                    datePreviousIndex] =
                                                                false;
                                                            daysBool[index] =
                                                                true;
                                                            datePreviousIndex =
                                                                index;
                                                            final DateFormat
                                                                formatter =
                                                                DateFormat
                                                                    .yMMMMd(
                                                                        'en_US');
                                                            final String
                                                                formattedDate =
                                                                formatter.format(
                                                                    listDate);
                                                            print(
                                                                formattedDate);
                                                            totalDate =
                                                                formattedDate;
                                                          });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              listDay.substring(
                                                                  0, 3),
                                                              style: TextStyle(
                                                                  color: daysBool[
                                                                          index]
                                                                      ? Colors
                                                                          .white
                                                                      : Color.fromRGBO(
                                                                          144,
                                                                          144,
                                                                          144,
                                                                          1),
                                                                  fontFamily:
                                                                      fontRegular),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            500),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            7)),
                                                                child: Text(
                                                                  "${listDate.toString().split(" ")[0].split("-")[2]}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          fontSemi),
                                                                )),
                                                            today
                                                                ? Container()
                                                                : datesWhenTestTake
                                                                            .contains(formattedDate.toString()) ==
                                                                        true
                                                                    ? Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: today
                                                                            ? mainColor
                                                                            : blue,
                                                                        size:
                                                                            10.5,
                                                                      )
                                                                    : Container(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: days.length,
                                            )),
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_back_ios_outlined,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      var firstDate =
                                                          year.toString() +
                                                              monthStringValue +
                                                              "01";
                                                      var dateIs =
                                                          DateTime.parse(
                                                              firstDate);
                                                      var firstDay =
                                                          DateFormat('EEEE')
                                                              .format(dateIs);
                                                      skipDays = _weekDaysFull
                                                          .indexOf(firstDay);
                                                      year--;
                                                      totalDate = monthVal +
                                                          " " +
                                                          day.toString() +
                                                          ", " +
                                                          year.toString();
                                                    });
                                                    setState(() {
                                                      var firstDate =
                                                          year.toString() +
                                                              monthStringValue +
                                                              "01";
                                                      var dateIs =
                                                          DateTime.parse(
                                                              firstDate);
                                                      var firstDay =
                                                          DateFormat('EEEE')
                                                              .format(dateIs);
                                                      skipDays = _weekDaysFull
                                                          .indexOf(firstDay);
                                                      totalDate = monthVal +
                                                          " " +
                                                          day.toString() +
                                                          ", " +
                                                          year.toString();
                                                    });
                                                  }),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18.0),
                                                child: Text(
                                                  '$year',
                                                  style: TextStyle(
                                                      fontFamily: fontBold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    size: 16,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      var firstDate =
                                                          year.toString() +
                                                              monthStringValue +
                                                              "01";
                                                      var dateIs =
                                                          DateTime.parse(
                                                              firstDate);
                                                      var firstDay =
                                                          DateFormat('EEEE')
                                                              .format(dateIs);
                                                      skipDays = _weekDaysFull
                                                          .indexOf(firstDay);
                                                      year++;
                                                    });
                                                    setState(() {
                                                      var firstDate =
                                                          year.toString() +
                                                              monthStringValue +
                                                              "01";
                                                      var dateIs =
                                                          DateTime.parse(
                                                              firstDate);
                                                      var firstDay =
                                                          DateFormat('EEEE')
                                                              .format(dateIs);
                                                      skipDays = _weekDaysFull
                                                          .indexOf(firstDay);
                                                      totalDate = monthVal +
                                                          " " +
                                                          day.toString() +
                                                          ", " +
                                                          year.toString();
                                                    });
                                                  }),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    _getMonth(
                                                        monthText: "Jan",
                                                        monthInt: 1,
                                                        monthValue: "January"),
                                                    _getMonth(
                                                        monthText: "Feb",
                                                        monthInt: 2,
                                                        monthValue: "February"),
                                                    _getMonth(
                                                        monthText: "Mar",
                                                        monthInt: 3,
                                                        monthValue: "March"),
                                                    _getMonth(
                                                        monthText: "Apr",
                                                        monthInt: 4,
                                                        monthValue: "April"),
                                                    _getMonth(
                                                        monthText: "May",
                                                        monthInt: 5,
                                                        monthValue: "May"),
                                                    _getMonth(
                                                        monthText: "Jun",
                                                        monthInt: 6,
                                                        monthValue: "June"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    _getMonth(
                                                        monthText: "Jul",
                                                        monthInt: 7,
                                                        monthValue: "July"),
                                                    _getMonth(
                                                        monthText: "Aug",
                                                        monthInt: 8,
                                                        monthValue: "August"),
                                                    _getMonth(
                                                        monthText: "Sep",
                                                        monthInt: 9,
                                                        monthValue:
                                                            "September"),
                                                    _getMonth(
                                                        monthText: "Oct",
                                                        monthInt: 10,
                                                        monthValue: "October"),
                                                    _getMonth(
                                                        monthText: "Nov",
                                                        monthInt: 11,
                                                        monthValue: "November"),
                                                    _getMonth(
                                                        monthText: "Dec",
                                                        monthInt: 12,
                                                        monthValue: "December"),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    248, 248, 248, 1),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.33,
                                                child: GridView.builder(
                                                  physics: ScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  itemCount: 31 + 7 + skipDays,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisSpacing: 0,
                                                    crossAxisCount: 7,
                                                    crossAxisSpacing: 20,
                                                  ),
                                                  itemBuilder: (context, i) {
                                                    if (!IsLeapYear(year) &&
                                                        month == 2 &&
                                                        i - 6 - skipDays ==
                                                            29) {
                                                      return Container();
                                                    }
                                                    if (i - 6 - skipDays ==
                                                            30 &&
                                                        month == 2) {
                                                      return Container();
                                                    }
                                                    if (i - 6 - skipDays ==
                                                            31 &&
                                                        shouldHideDay()) {
                                                      return Container();
                                                    }
                                                    if (i < 7)
                                                      return _weekDayTitle(i);
                                                    else if (i - 6 - skipDays <
                                                        1) {
                                                      return Container();
                                                    } else if (i -
                                                            6 -
                                                            skipDays <=
                                                        31) {
                                                      return _getDay(
                                                          dayInt:
                                                              i - 6 - skipDays,
                                                          dayText:
                                                              (i - 6 - skipDays)
                                                                  .toString());
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                )),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      )
                                : Container(),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 100) *
                                      1,
                            ),
                          ],
                        ),
                      ),
                      reverse
                          ? Expanded(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int i) {
                                    var time = surveyHistory[i][0];
                                    var date = surveyHistory[i][1];
                                    var surveyData = surveyHistory[i][2];
                                    var result = surveyHistory[i][3];
                                    var timeStamp = surveyHistory[i][4];
                                    String elapsedTime =
                                        TimeElapsed().fromDateStr(timeStamp);
                                    elapsedTime = elapsedTime == "Now"
                                        ? "1m"
                                        : elapsedTime;
                                    var text = result < 5
                                        ? 'It is good to see that you are taking care of yourself\n\nKeep it up :)'
                                        : result < 10
                                            ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                                            : result <= 15
                                                ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                                                : 'Your test results indicate some symptoms of depression. You are advised to seek urgent medical care promptly. Visit the ER or call 911 now.';

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Column(
                                        children: [
                                          HistorBox(
                                              time,
                                              date,
                                              surveyData,
                                              result,
                                              surveyHistory[i],
                                              i,
                                              function),
                                          expandableBool[i]
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 18.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        viewAnswerColor = true;
                                                      });
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ParticularHistory(
                                                                      surveyHistory[
                                                                          i])));
                                                      setState(() {
                                                        viewAnswerColor = false;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              100) *
                                                          42,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            236, 236, 236, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              offset:
                                                                  Offset(0, 0),
                                                              color: Color
                                                                  .fromRGBO(
                                                                      151,
                                                                      151,
                                                                      151,
                                                                      1), //(x,y)
                                                              blurRadius: 0,
                                                              spreadRadius: 0),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    100) *
                                                                1.5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            18.0),
                                                                child: Text(
                                                                  "Test Taken - PHQ-9",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          fontRegular,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            18.0),
                                                                child:
                                                                    Container(
                                                                  height: (MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          100) *
                                                                      5,
                                                                  width: (MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          100) *
                                                                      5,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(40),
                                                                      border: Border.all(
                                                                          color: result < 5
                                                                              ? Colors.green
                                                                              : result < 10
                                                                                  ? Colors.yellow
                                                                                  : result <= 14
                                                                                      ? Colors.red.shade200
                                                                                      : Colors.red,
                                                                          width: 4)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    100) *
                                                                5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18.0),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  width: double
                                                                          .infinity -
                                                                      20,
                                                                  height: (MediaQuery.of(context)
                                                                              .size
                                                                              .height /
                                                                          100) *
                                                                      24,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black54,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          offset: Offset(
                                                                              0,
                                                                              0),
                                                                          color: Color.fromRGBO(
                                                                              151,
                                                                              151,
                                                                              151,
                                                                              1), //(x,y)
                                                                          blurRadius:
                                                                              6,
                                                                          spreadRadius:
                                                                              0),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            8.0,
                                                                        vertical:
                                                                            12),
                                                                    child: Text(
                                                                      '$text',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontFamily:
                                                                              fontRegular),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    100) *
                                                                1.5,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .access_time,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          82,
                                                                          82,
                                                                          82,
                                                                          1),
                                                                  size: 18,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "$elapsedTime ago",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            fontRegular,
                                                                        color: Color.fromRGBO(
                                                                            82,
                                                                            82,
                                                                            82,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              5.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .circle,
                                                                        color: Color.fromRGBO(
                                                                                82,
                                                                                82,
                                                                                82,
                                                                                1)
                                                                            .withOpacity(0.4),
                                                                        size: 8,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "$time",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            fontRegular,
                                                                        color: Color.fromRGBO(
                                                                            82,
                                                                            82,
                                                                            82,
                                                                            1),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: surveyHistory.length,
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int i) {
                                  var time = surveyHistory[i][0];
                                  var date = surveyHistory[i][1];
                                  var surveyData = surveyHistory[i][2];
                                  var result = surveyHistory[i][3];
                                  var timeStamp = surveyHistory[i][4];
                                  String elapsedTime =
                                      TimeElapsed().fromDateStr(timeStamp);
                                  elapsedTime =
                                      elapsedTime == "Now" ? "1m" : elapsedTime;
                                  var text = result < 5
                                      ? 'It is good to see that you are taking care of yourself\n\nKeep it up :)'
                                      : result < 10
                                          ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                                          : result <= 15
                                              ? 'Your test results indicate some symptoms of depression. You are advised to retake the PHQ9 test in 2 weeks and to book a consultation session with your primary health care provider.'
                                              : 'Your test results indicate some symptoms of depression. You are advised to seek urgent medical care promptly. Visit the ER or call 911 now.';

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Column(
                                      children: [
                                        HistorBox(
                                            time,
                                            date,
                                            surveyData,
                                            result,
                                            surveyHistory[i],
                                            i,
                                            function),
                                        expandableBool[i]
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 18.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      viewAnswerColor = true;
                                                    });
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ParticularHistory(
                                                                    surveyHistory[
                                                                        i])));
                                                    setState(() {
                                                      viewAnswerColor = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .height /
                                                                100) *
                                                            42,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          236, 236, 236, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            offset:
                                                                Offset(0, 0),
                                                            color:
                                                                Color.fromRGBO(
                                                                    151,
                                                                    151,
                                                                    151,
                                                                    1), //(x,y)
                                                            blurRadius: 0,
                                                            spreadRadius: 0),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  100) *
                                                              1.5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          18.0),
                                                              child: Text(
                                                                "Test Taken - PHQ-9",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        fontRegular,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          18.0),
                                                              child: Container(
                                                                height: (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        100) *
                                                                    5,
                                                                width: (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        100) *
                                                                    5,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(40),
                                                                    border: Border.all(
                                                                        color: result < 5
                                                                            ? Colors.green
                                                                            : result < 10
                                                                                ? Colors.yellow
                                                                                : result <= 14
                                                                                    ? Colors.red.shade200
                                                                                    : Colors.red,
                                                                        width: 4)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  100) *
                                                              5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18.0),
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                width: double
                                                                        .infinity -
                                                                    20,
                                                                height: (MediaQuery.of(context)
                                                                            .size
                                                                            .height /
                                                                        100) *
                                                                    24,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black54,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        offset: Offset(
                                                                            0,
                                                                            0),
                                                                        color: Color.fromRGBO(
                                                                            151,
                                                                            151,
                                                                            151,
                                                                            1), //(x,y)
                                                                        blurRadius:
                                                                            6,
                                                                        spreadRadius:
                                                                            0),
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0,
                                                                      vertical:
                                                                          12),
                                                                  child: Text(
                                                                    '$text',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontFamily:
                                                                            fontRegular),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  100) *
                                                              1.5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      18),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .access_time,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        82,
                                                                        82,
                                                                        82,
                                                                        1),
                                                                size: 18,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "$elapsedTime ago",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          fontRegular,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              82,
                                                                              82,
                                                                              82,
                                                                              1),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            5.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .circle,
                                                                      color: Color.fromRGBO(
                                                                              82,
                                                                              82,
                                                                              82,
                                                                              1)
                                                                          .withOpacity(
                                                                              0.4),
                                                                      size: 8,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "$time",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          fontRegular,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              82,
                                                                              82,
                                                                              82,
                                                                              1),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  );
                                },
                                itemCount: surveyHistory.length,
                              ),
                            )
                    ],
                  )),
            ),
    );
  }
}

                                                                                             
