import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/models/prescrption.dart';
import 'package:Xpresspill/models/User.dart';
//import 'package:Xpresspill/pages/home.dart';
//import 'package:photo_view/photo_view.dart';

TextStyle defaultStyle() {
  return TextStyle(
    fontFamily: primaryFontFamily,
  );
}

class PrescriptionResult extends StatefulWidget {
  final Prescription prescription;
  final String currentUserId;

  PrescriptionResult(this.prescription, this.currentUserId);

  @override
  _PrescriptionResultState createState() =>
      _PrescriptionResultState(this.prescription, this.currentUserId);
}

class _PrescriptionResultState extends State<PrescriptionResult> {
  final Prescription prescription;
  final String currentUserId;
  _PrescriptionResultState(this.prescription, this.currentUserId);
  User user;

  @override
  void initState() {
    _getUserDetails(prescription.userId);
    // _getCurrentUserId();
    super.initState();
  }

//  _getCurrentUserId()async
//  {
//    SharedPreferences preferences=await SharedPreferences.getInstance();
//    setState(() {
//      currentUserId=preferences.getString("userId");
//    });
//  }

  void _getUserDetails(userId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    setState(() {
      user = User.fromDocument(doc);
      print("-------------------------------${user.firstName}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10.0),
      height:size.height*0.75,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              //leading: prescription.isLocked?Icon(AntDesign.lock):Icon(AntDesign.unlock),
              title: user != null
                  ? Text(
                      "${user.firstName} ${user.lastName}",
                      style: defaultStyle(),
                    )
                  : Text(""),
              subtitle: user != null
                  ? Text(
                      "${user.contactNumber}",
                      style: defaultStyle(),
                    )
                  : Text(""),
              trailing: IconButton(
                  icon: prescription.isLocked
                      ? Icon(
                          AntDesign.lock,
                          color: greenColor,
                        )
                      : Icon(
                          AntDesign.unlock,
                          color: redColor,
                        )),
              onTap: prescription.isLocked
                  ? null
                  : () {
                      print("here------------");
                      if (currentUserId != null) {
                        FirebaseFirestore.instance
                            .collection("prescriptions")
                            .doc(prescription.prescriptionId)
                            .update({
                          "isLocked": true,
                          "lockedBy": currentUserId
                        }).then((value) {
                          setState(() {});
                        });
                      }
                    },
            ),
            Container(
              height: size.height * 0.4,
              width: size.width * 0.4,
              child: Image(
                  image: NetworkImage("${prescription.prescriptionUrl}"),
                  fit: BoxFit.fill),
            ),
            prescription.isLocked
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            prescription.isEntered
                                ? AntDesign.check
                                : Icons.clear,
                            color:
                                prescription.isEntered ? greenColor : redColor,
                          ),
                          onPressed: !prescription.isEntered
                              ? () {
                                  FirebaseFirestore.instance
                                      .collection("prescriptions")
                                      .doc(prescription.prescriptionId)
                                      .update({"isEntered": true}).then(
                                          (value) {
                                    setState(() {
                                      this.prescription.isEntered = true;
                                    });
                                  });
                                }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            prescription.isDispatched
                                ? Icons.check
                                : Icons.clear,
                            color: prescription.isDispatched
                                ? greenColor
                                : redColor,
                          ),
                          onPressed: (prescription.isEntered &&
                                  !prescription.isDispatched)
                              ? () {
                                  FirebaseFirestore.instance
                                      .collection("prescriptions")
                                      .doc(prescription.prescriptionId)
                                      .update({"isDispatched": true}).then(
                                          (value) {
                                    setState(() {
                                      this.prescription.isDispatched = true;
                                    });
                                  });
                                }
                              : null,
                        ),
                        IconButton(
                          icon: Icon(
                            prescription.isDelivered
                                ? Icons.check
                                : Icons.clear,
                            color: prescription.isDelivered
                                ? greenColor
                                : redColor,
                          ),
                          onPressed: (prescription.isDispatched &&
                                  !prescription.isDelivered)
                              ? () {
                                  FirebaseFirestore.instance
                                      .collection("prescriptions")
                                      .doc(prescription.prescriptionId)
                                      .update({"isDelivered": true}).then(
                                          (value) {
                                    setState(() {
                                      this.prescription.isDelivered = true;
                                    });
                                  });
                                }
                              : null,
                        )
                      ],
                    ),
                  )
                : Text(""),
            prescription.isLocked
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Entered",
                          style: firsttextstyle,
                        ),
                        Text(
                          "Dispatched",
                          style: firsttextstyle,
                        ),
                        Text(
                          "Delivered",
                          style: firsttextstyle,
                        ),
                      ],
                    ),
                  )
                : Text("")
          ],
        ),
      ),
    );
  }
}
