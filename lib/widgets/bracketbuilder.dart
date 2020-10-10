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
      height: MediaQuery.of(context).size.height / 3.5,
      child: Text(
        "Hector's Widget",
        textAlign: TextAlign.center,
      ),
    );
  }
}
