import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 200,
            width: 200,
            child: Image.asset(
              "assets/images/empty_feed.png",
              fit: BoxFit.contain,
            ),
          ),
        )
      ],
    );
  }
}
