import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/theme/theme.dart';

class BracketBuilder extends StatefulWidget {
  List<List<Team>> levels = [];
  List<Team> _teams = [];

  BracketBuilder(List<Team> tl) {
    this._teams = [
      Team(),
      Team(),
      Team(),
      Team(),
      Team(),
      Team(),
      Team(),
      Team()
    ];
    // Hardcode  = [Team(), Team()] to test Andrew, Ezra, Hector Widget

    this.levels = List<List<Team>>((log(_teams.length) / log(2)).ceil() + 1);
    for (int i = levels.length - 1; i >= 0; i--)
      levels[i] = List<Team>(pow(2, i));
    levels[0] = _teams;
  }
  @override
  _BracketBuilderState createState() => _BracketBuilderState();
}

class _BracketBuilderState extends State<BracketBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: AndrewAndEzraWidget(widget.levels, this),
    );
  }
}

class TeamCard extends StatelessWidget {
  Team team;
  _BracketBuilderState bbs;
  int col, row;

  TeamCard(Team t, _BracketBuilderState b, int c, int r) {
    team = t;
    bbs = b;
    col = c;
    row = r;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        enabled: false,
        leading: Icon(
          Icons.circle,
          color: this.team.getTeamColor,
          size: 20,
        ),
        title: Text(
          "${this.team.getTeamName}",
        ),

        ///subtitle: Text("${this.team.playerList[0]}"),
        onTap: () {
          if (col + 1 < bbs.widget.levels.length) {
            bbs.setState(() {
              bbs.widget.levels[col + 1][(row / 2).floor()] = this.team;
            });
          } else {
            return WinAndResetWidget(bbs.widget.levels);
          }
        },
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
  _BracketBuilderState bbs;

  AndrewAndEzraWidget(List<List<Team>> levels, _BracketBuilderState b) {
    this.level = levels;
    this.bbs = b;
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
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.level.length,
          itemBuilder: (context, i) {
            print("Columns: ${widget.level.length}");
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: Expanded(
                    child: ListView.builder(
                  itemCount: widget.level[i].length,
                  itemBuilder: (context, j) {
                    print("Cards/Teams: ${widget.level[i].length}");
                    return TeamCard(widget.level[i][j], widget.bbs, i, j);
                    // return Container(
                    //   color: j % 2 == 0 ? Colors.red : Colors.blue,
                    //   child: TeamCard(widget.level[i][j]),
                    //   width: 300,
                    //   height: 100,
                    // );
                  },
                )));
          },
        ));
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
                  "somebody won",
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
                    if (widget.level[widget.level.length - 1].isNotEmpty)
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
