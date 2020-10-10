import 'package:flutter/material.dart';

import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/theme/theme.dart';

class BracketBuilder extends StatefulWidget {
  List<Widget> levels = [];
  List<Team> _teams = [];
  BracketBuilder(List<Team> tl) {
    this._teams =
        tl; // Hardcode  = [Team(), Team()] to test Andrew, Ezra, Hector Widget
    this._teams = [];
  }
  @override
  _BracketBuilderState createState() => _BracketBuilderState();
}

class _BracketBuilderState extends State<BracketBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3.5,
        child: switchDisplayChildBasedOnListSize(widget._teams));
  }
}

class TeamCard extends StatelessWidget {
  Team t1, t2;
  TeamCard(this.t1, this.t2);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("${this.t1} vs. ${this.t2}"),
        onTap: null,
      ),
    );
  }
}

// super long name for explanation
Widget switchDisplayChildBasedOnListSize(List<Team> t) {
  switch (t.length) {
    case 0:
      return NoTeamsWidget();
      break;
    case 1:
      return WinAndResetWidget(t);
      break;
    default:
      return AndrewAndEzraWidget(t);
      break;
  }
}

class AndrewAndEzraWidget extends StatefulWidget {
  List<Team> teams;
  AndrewAndEzraWidget(List<Team> tl) {
    this.teams = tl;
  }
  @override
  _AndrewAndEzraWidgetState createState() => _AndrewAndEzraWidgetState();
}

class _AndrewAndEzraWidgetState extends State<AndrewAndEzraWidget> {
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
                    onTap: () {},
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
  }
}

class WinAndResetWidget extends StatefulWidget {
  List<Team> winnerz;
  WinAndResetWidget(List<Team> tl) {
    this.winnerz = tl;
  }
  @override
  _WinAndResetWidgetState createState() => _WinAndResetWidgetState();
}

class _WinAndResetWidgetState extends State<WinAndResetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5.0),
      width: MediaQuery.of(context).size.width,
      child: Card(
          elevation: 10.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "🎉 Congratulations, 🎉",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: davys_grey),
                ),
                Text(
                  "${widget.winnerz[0].teamName}",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "you won",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: davys_grey),
                ),
                RaisedButton(
                  // on pressed needs to reset everything
                  onPressed: () {
                    if (widget.winnerz.isNotEmpty) widget.winnerz.removeLast();
                    print("needs implementation.");
                  },
                  child: Text(
                    "Restart",
                    style: TextStyle(color: lotion),
                  ),
                  color: middle_green,
                ),
              ],
            ),
          )),
    );
  }
}

class NoTeamsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Enter player data and press the checkbox to recieve a bracket.",
          style: TextStyle(color: davys_grey),
          textAlign: TextAlign.center,
        ));
  }
}
