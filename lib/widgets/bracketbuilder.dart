import 'package:flutter/material.dart';

import 'package:gunfight_picker/classes/Team.dart';

class BracketBuilder extends StatefulWidget {
  List<Widget> levels = [];
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text("Team 1"),
                    subtitle: Text(""),
                    onTap: null,
                  ),
                ),
                Card(),
                Card(),
                Card(),
                Card(),
                Card(),
                Card(),
                Card(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Card(),
                Card(),
                Card(),
                Card(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Card(),
                Card(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Card(),
              ],
            ),
          ),
        ],
      ),
    );
    //padding: EdgeInsets.all(10.0),
  }
}
