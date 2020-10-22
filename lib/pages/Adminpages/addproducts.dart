import 'dart:math';

import 'package:Xpresspill/constant.dart';
import 'package:Xpresspill/pages/Adminpages/manageproducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';

import "package:flutter/material.dart";

import 'dart:async';

import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:path/path.dart';

import 'package:image_picker_web/image_picker_web.dart';

import 'package:mime_type/mime_type.dart';
import "package:intl/intl.dart";
import 'package:random_string/random_string.dart';

class Addproducts extends StatefulWidget {
  @override
  _AddproductsState createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  String authorName, title, desc;

  bool _isLoading = false;

  DateTime now = DateTime.now();
  Image image;

  String userid;
  var imageUri;
  final productkey = GlobalKey<FormState>();
  TextEditingController productname = TextEditingController();
  TextEditingController productdesc = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  // imagePicker() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   return ImagePickerWeb.getImageInfo.then((MediaInfo mediaInfo) {
  //     uploadFile(mediaInfo, 'products', mediaInfo.fileName);
  //   });
  // }

  // uploadFile(MediaInfo mediaInfo, String ref, String fileName) {
  //   try {

  //     // var rng = new Random();
  //     // String documentID = rng.nextInt(1000000).toString();

  //     String mimeType = mime(basename(mediaInfo.fileName));
  //     var metaData = UploadMetadata(contentType: mimeType);
  //     StorageReference storageReference = storage().ref(ref).child(fileName);

  //     UploadTask uploadTask = storageReference.put(mediaInfo.data, metaData);

  //     uploadTask.future.then((snapshot) => {
  //           Future.delayed(Duration(seconds: 1)).then((value) => {
  //                 snapshot.ref.getDownloadURL().then((dynamic uri) {
  //                   imageUri = uri;

  //                   setState(() {
  //                     imageUri = uri;
  //                     _isLoading = false;
  //                   });
  //                   print('Download URL: ${imageUri.toString()}');
  //                 })
  //               })
  //         });
  //   } catch (e) {
  //     print('File Upload Error: $e');
  //   }
  // }

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
    if (productkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
        // print("hii");
      });

      var rng = new Random();
      String documentID = rng.nextInt(10000000).toString();

      await FirebaseFirestore.instance
          .collection("products")
          .doc(documentID)
          .set({
        "mediaUrl": imageUri.toString(),
        "createdAt": DateTime.now(),
        "productId": documentID,
        "productDescription": productdesc.text,
        "productName": productname.text,
        "productPrice": price.text,
        "productQuantity": quantity.text,
        "updatedAt": DateTime.now()
      });

      setState(() {
        _isLoading = false;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Manageproduct()));
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
                  Form(
                    key: productkey,
                    child: Column(children: [
                      Row(children: [
                        SizedBox(width: size.width * 0.4),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: productname,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.medical_services,
                                      color: Colors.black),
                                  hintText:
                                      "Enter Product name                   ",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                  border: InputBorder.none),
                              validator: (val) {
                                return val.length > 2
                                    ? null
                                    : "Enter 2+ charcter for product name";
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
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: price,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.attach_money,
                                      color: Colors.black),
                                  hintText: " Enter product price             ",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  counterStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  border: InputBorder.none),
                              validator: (val) {
                                return val.length > 0
                                    ? null
                                    : "Enter valid price";
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
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: quantity,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.format_list_numbered_sharp,
                                    color: Colors.black,
                                  ),
                                  hintText: " Enter product Quantity         ",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  counterStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  border: InputBorder.none),
                              validator: (val) {
                                return val.length > 0
                                    ? null
                                    : "Enter valid Quantity";
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
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              controller: productdesc,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.description,
                                    color: Colors.black,
                                  ),
                                  hintText:
                                      " Enter product description            ",
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  counterStyle: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                  border: InputBorder.none),
                              validator: (val) {
                                return val.length > 3
                                    ? null
                                    : "Enter 3+ character in product description";
                              },
                            ),
                          ),
                        ),
                      ]),
                    ]),
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
