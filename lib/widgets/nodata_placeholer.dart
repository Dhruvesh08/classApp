import 'package:flutter/material.dart';

class NodataPlaceHolder extends StatefulWidget {
  final imageUrl;

  const NodataPlaceHolder({Key key, this.imageUrl}) : super(key: key);

  @override
  _NodataPlaceHolderState createState() => _NodataPlaceHolderState();
}

class _NodataPlaceHolderState extends State<NodataPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    final mediaqurey = MediaQuery.of(context).size;
    return Container(
      height: mediaqurey.height * 0.4,
      width: mediaqurey.height * 0.4,
      child: Image.asset(
        widget.imageUrl,
        fit: BoxFit.contain,
      ),
    );
  }
}
