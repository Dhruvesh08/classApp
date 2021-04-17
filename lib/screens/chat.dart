import 'package:classapp/widgets/nodata_placeholer.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NodataPlaceHolder(
            imageUrl: "assets/images/chat.png",
          ),
        ],
      ),
    );
  }
}
