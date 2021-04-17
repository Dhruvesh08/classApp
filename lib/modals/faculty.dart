import 'package:flutter/cupertino.dart';

class Faculty {
  String name;
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

  Faculty({
    @required this.name,
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
}
