import 'package:classapp/modals/user.dart';
import 'package:flutter/material.dart';
import './home.dart';

class Profile extends StatelessWidget {
  final User user;

  const Profile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text("${user.id}")
        ],
      ),
    );
  }
}
