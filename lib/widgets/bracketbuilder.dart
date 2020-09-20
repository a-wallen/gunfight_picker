import 'package:flutter/material.dart';

class BracketBuilder extends StatefulWidget {
  @override
  _BracketBuilderState createState() => _BracketBuilderState();
}

class _BracketBuilderState extends State<BracketBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 100.0,
      color: Colors.red,
      child: Text("Hector's Widget"),
    );
  }
}