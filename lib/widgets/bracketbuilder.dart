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
        //padding: EdgeInsets.all(10.0),
        height: 180,
        child: Column(
          children: [
            Text(
              "Hector's Widget",
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
