import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/theme/theme.dart';

class BracketBuilder extends StatefulWidget {
  List<List<Team>> levels = [];
  List<Team> _teams = [];

  BracketBuilder(List<Team> tl) {
    this._teams = [Team(), Team(), Team(), Team(), Team(), Team(), Team(), Team()];
    // Hardcode  = [Team(), Team()] to test Andrew, Ezra, Hector Widget

    this.levels = List<List<Team>>((log(_teams.length) / log(2)).ceil());
    levels[levels.length] = _teams;
  }
  @override
  _BracketBuilderState createState() => _BracketBuilderState();
}

class _BracketBuilderState extends State<BracketBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3.5,
        child: AndrewAndEzraWidget(widget.levels),
    );
  }
}

class TeamCard extends StatelessWidget {
  Team team;
  TeamCard(Team team);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("${this.team.name}}"),
        onTap: null,
      ),
    );
  }
}

// super long name for explanation
// Widget switchDisplayChildBasedOnListSize(List<Team> t) {
//   switch (t.length) {
//     case 0:
//       return NoTeamsWidget();
//       break;
//     case 1:
//       return WinAndResetWidget(t);
//       break;
//     default:
//       return AndrewAndEzraWidget(t);
//       break;
//   }
// }

class AndrewAndEzraWidget extends StatefulWidget {

  List<List<Team>> level;

  AndrewAndEzraWidget(List<List<Team>> levels) {
    this.level = levels;
  }

  @override
  _AndrewAndEzraWidgetState createState() => _AndrewAndEzraWidgetState();
}

class _AndrewAndEzraWidgetState extends State<AndrewAndEzraWidget> {

  // void initState() {
  //   widget.level = List(List)
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.level.length,
        itemBuilder: (context, index) {
          return Expanded(
            child: ListView.builder(
                itemCount: widget.level[index].length,
                itemBuilder: (context, index2) {
                  return TeamCard(level[index][index2]);
                },
            ),
          );
        },
      )
    );
  }
}

class WinAndResetWidget extends StatefulWidget {
  List level = [];

  WinAndResetWidget(List<List<Team>> levels) {
    this.level = levels;
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
                    if (widget.level[level.length-1].isNotEmpty)
                      //do something;
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
