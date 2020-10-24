// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:corsac_jwt/corsac_jwt.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// //import 'package:jaguar_jwt/jaguar_jwt.dart';
// import 'package:Xpresspill/models/User.dart';
// //import 'package:Xpresspill/pages/home.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserService {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final storage = new FlutterSecureStorage();
//   final String sharedKey = 'sharedKey';
//   int statusCode;
//   String msg;
//   User currentUserDetails;
//   SharedPreferences sharedPreferences;

//   // void createAndStoreJWTToken(String uid) async {
//   //   var builder = new JWTBuilder();
//   //   var token = builder
//   //     ..expiresAt = new DateTime.now().add(new Duration(hours: 3))
//   //     ..setClaim('data', {'uid': uid})
//   //     ..getToken();

//   //   var signer = new JWTHmacSha256Signer(sharedKey);
//   //   var signedToken = builder.getSignedToken(signer);
//   //   await storage.write(key: 'token', value: signedToken.toString());
//   // }

//   // String validateToken(String token) {
//   //   var signer = new JWTHmacSha256Signer(sharedKey);
//   //   var decodedToken = new JWT.parse(token);
//   //   if (decodedToken.verify(signer)) {
//   //     final parts = token.split('.');
//   //     final payload = parts[1];
//   //     final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
//   //     final int expiry = jsonDecode(decoded)['exp'] * 1000;
//   //     final currentDate = DateTime.now().millisecondsSinceEpoch;
//   //     if (currentDate > expiry) {
//   //       return null;
//   //     }
//   //     return jsonDecode(decoded)['data']['uid'];
//   //   }
//   //   return null;
//   // }

//   void logOut(context) async {
//     await storage.delete(key: 'token');
//     sharedPreferences = await SharedPreferences.getInstance();
//     sharedPreferences.clear();
//     sharedPreferences.commit();
//     Navigator.of(context).pushReplacementNamed('/');
//   }

//   // Future<void> login(userValues) async {
//   //   String email = userValues['email'];
//   //   String password = userValues['password'];

//   //   await _auth
//   //       .signInWithEmailAndPassword(email: email, password: password)
//   //       .then((dynamic user) async {
//   //     final FirebaseUser currentUser = await _auth.currentUser();
//   //     final uid = currentUser.uid;
//   //     DocumentSnapshot doc = await userRef.document(uid).get();
//   //     currentUserDetails = User.fromDocument(doc);
//   //     sharedPreferences = await SharedPreferences.getInstance();
//   //     sharedPreferences.setString("userId", currentUserDetails.id);
//   //     sharedPreferences.setString(
//   //         "userFirstName", currentUserDetails.firstName);
//   //     sharedPreferences.setString("userLastName", currentUserDetails.lastName);
//   //     sharedPreferences.setString("userEmail", currentUserDetails.email);
//   //     sharedPreferences.setString(
//   //         "userContactNumber", currentUserDetails.contactNumber);
//   //     sharedPreferences.setBool("isAdmin", currentUserDetails.isAdmin);
//   //     sharedPreferences.setBool(
//   //         "isPharmacist", currentUserDetails.isPharmacist);
//   //     createAndStoreJWTToken(uid);

//   //     statusCode = 200;
//   //   }).catchError((error) {
//   //     handleAuthErrors(error);
//   //   });
//   // }

//   Future<String> getUserId() async {
//     var token = await storage.read(key: 'token');
//     var uid = validateToken(token);
//     return uid;
//   }

//   Future<void> signup(userValues) async {
//     String email = userValues['email'];
//     String password = userValues['password'];

//     await _auth
//         .createUserWithEmailAndPassword(email: email, password: password)
//         .then((dynamic user) {
//       String uid = user.user.uid;
//       _firestore.collection('users').document(uid).setData({
//         'firstName': capitalizeName(userValues['firstName']),
//         'lastName': capitalizeName(userValues['lastName']),
//         'email': userValues['email'],
//         'contactNumber': userValues['contactNumber'],
//         'id': uid,
//         'dob': userValues['dob'],
//         'createdAt': DateTime.now(),
//         'isAdmin': false,
//         'isPharmacist': false
//       });

//       statusCode = 200;
//     }).catchError((error) {
//       handleAuthErrors(error);
//     });
//   }

//   void handleAuthErrors(error) {
//     String errorCode = error.code;
//     switch (errorCode) {
//       case "ERROR_EMAIL_ALREADY_IN_USE":
//         {
//           statusCode = 400;
//           msg = "Email ID already existed";
//         }
//         break;
//       case "ERROR_WRONG_PASSWORD":
//         {
//           statusCode = 400;
//           msg = "Password is wrong";
//         }
//     }
//   }

//   String capitalizeName(String name) {
//     name = name[0].toUpperCase() + name.substring(1);
//     return name;
//   }

//   Future<String> userEmail() async {
//     var user = await _auth.currentUser();
//     return user.email;
//   }
// }
