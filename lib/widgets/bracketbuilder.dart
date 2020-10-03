import 'package:flutter/material.dart';

import 'package:gunfight_picker/classes/Team.dart';

class BracketBuilder extends StatefulWidget {
  List<Team> _teams;
  BracketBuilder(List<Team> tl) {
    this._teams = tl;
  }
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
