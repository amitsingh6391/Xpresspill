import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final String dob;
  final bool isAdmin;
  final bool isPharmacist;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.contactNumber,
    this.dob,
    this.isAdmin,
    this.isPharmacist,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      firstName: doc['firstName'],
      lastName: doc['lastName'],
      email: doc['email'],
      contactNumber: doc['contactNumber'],
      dob: doc['dob'],
      isAdmin: doc['isAdmin'],
      isPharmacist: doc['isPharmacist'],
    );
  }
}
