import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  String name;
  String id;
  String middleName;
  String lastName;
  String mobileNo;
  String department;
  String address;
  String city;
  String pincode;
  String state;
  String country;
  bool isFaculty;

  User({
    @required this.name,
    @required this.id,
    @required this.middleName,
    @required this.lastName,
    @required this.mobileNo,
    @required this.department,
    @required this.address,
    @required this.city,
    @required this.pincode,
    @required this.state,
    @required this.country,
    this.isFaculty = true,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      name: doc['userName'],
      id: doc['id'],
      middleName: doc['middleName'],
      lastName: doc['lastName'],
      mobileNo: doc['mobile'],
      department: doc['department'],
      address: doc['address'],
      city: doc['city'],
      pincode: doc['pincode'],
      state: doc['state'],
      country: doc['country'],
    );
  }
}
