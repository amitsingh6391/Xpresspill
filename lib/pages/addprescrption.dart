import 'dart:math';

import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/pages/Adminpages/manageproducts.dart';
import 'package:Xpresspill/pages/homepgae.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

import "package:flutter/material.dart";

import 'dart:async';

import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:path/path.dart';

import 'package:image_picker_web/image_picker_web.dart';

import 'package:mime_type/mime_type.dart';
import "package:intl/intl.dart";
import 'package:random_string/random_string.dart';

class Addprescrption extends StatefulWidget {
  String userid;
  Addprescrption({@required this.userid});

  @override
  _AddprescrptionState createState() => _AddprescrptionState();
}

class _AddprescrptionState extends State<Addprescrption> {
  String authorName, title, desc;

  bool _isLoading = false;

  DateTime now = DateTime.now();
  Image image;

  var imageUri;
  final productkey = GlobalKey<FormState>();
  TextEditingController productname = TextEditingController();
  TextEditingController productdesc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  imagePicker() {
    setState(() {
      _isLoading = true;
    });
    return ImagePickerWeb.getImageInfo.then((MediaInfo mediaInfo) {
      uploadFile(mediaInfo, 'products', mediaInfo.fileName);
    });
  }

  uploadFile(MediaInfo mediaInfo, String ref, String fileName) {
    try {
      //var x = ${randomAlphaNumeric(9)}.jpg;

      String mimeType = mime(basename(mediaInfo.fileName));
      var metaData = UploadMetadata(contentType: mimeType);
      StorageReference storageReference =
          storage().ref(ref).child("${randomAlphaNumeric(9)}.jpg");

      UploadTask uploadTask = storageReference.put(mediaInfo.data, metaData);

      uploadTask.future.then((snapshot) => {
            Future.delayed(Duration(seconds: 1)).then((value) => {
                  snapshot.ref.getDownloadURL().then((dynamic uri) {
                    imageUri = uri;

                    setState(() {
                      imageUri = uri;
                      _isLoading = false;
                    });
                    print('Download URL: ${imageUri.toString()}');
                  })
                })
          });
    } catch (e) {
      print('File Upload Error: $e');
    }
  }

  uploadproduct(BuildContext context) async {
    if (imageUri != null) {
      setState(() {
        _isLoading = true;
        // print("hii");
      });

      await FirebaseFirestore.instance
          .collection("prescriptions")
          .doc(widget.userid)
          .set({
        "prescriptionUrl": imageUri.toString(),
        "createdAt": DateTime.now(),
        "prescriptionId": widget.userid,
        "isDelivered": false,
        "isEntered": false,
        "isLocked": true,
        "lockedBy": "",
        "userId": widget.userid
      });

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      showsuccess(context);
    }
  }

  showsuccess(context) {
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
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => Homepage()));
                },
                child: Text("ok"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            "Add new product",
            style:
                TextStyle(color: Colors.black, fontFamily: primaryFontFamily),
          ),
        ),
        body: _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                children: [
                  imageUri == null
                      ? GestureDetector(
                          onTap: () {
                            imagePicker();
                          },
                          child: CircleAvatar(
                              radius: 100, child: Text("Upload Product image")),
                        )
                      : Container(
                          height: size.height * 0.3,
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: NetworkImage(imageUri.toString()))),
                        ),
                  FlatButton(
                    onPressed: () async {
                      uploadproduct(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.cloud_upload, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              )));
  }
}
