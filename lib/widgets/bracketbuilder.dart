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
      // Team(),
      // Team(),
      // Team(),
      // Team(),
      // Team(),
      // Team(),
    ];
    // Hardcode  = [Team(), Team()] to test Andrew, Ezra, Hector Widget

    this.levels = List<List<Team>>((log(_teams.length) / log(2)).ceil() + 1);
    levels[0] = _teams;
    for (int i = 1; i < levels.length; i++)
      levels[i] = List<Team>()..length = (levels[i-1].length/2).ceil();
  }
  @override
  _BracketBuilderState createState() => _BracketBuilderState();
}

class _BracketBuilderState extends State<BracketBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      child: AndrewAndEzraWidget(widget.levels, this),
    );
  }
}

class TeamCard extends StatelessWidget {
  Team team;
  _BracketBuilderState bbs;
  int position;
  int j;

  TeamCard(Team t, _BracketBuilderState b, int index, int index2) {
    team = t;
    bbs = b;
    position = index;
    j = index2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: min(MediaQuery.of(context).size.height/2.55 / (bbs.widget.levels[position].length*0.75), 75),
      child: Card(
        elevation: 2.0,
        child: ListTile(
          leading: Icon(
            Icons.details,
            color: this.team.getTeamColor,
            size: 30,
          ),
          title: Text(
            "${this.team.getTeamName}",
          ),

          ///subtitle: Text("${this.team.playerList[0]}"),
          onTap: () {
            print("Card/row index: ");
            print(j);

            // int evenOdd = j % 2 == 0 ? 1 : -1;
            // Team opponent = bbs.widget.levels[position][j + evenOdd];
            //
            // print("opponent: ");
            // print(j + evenOdd);

            // bool nextContainsSelf = bbs.widget.levels[position+1].contains(team);
            // bool nextContainsOpponent = bbs.widget.levels[position+1].contains(opponent);
            bool hasWon = position+1 == bbs.widget.levels.length;

            // print("next col contains self: ");
            // print(nextContainsSelf);
            //
            // print("next col contains opponent: ");
            // print(nextContainsOpponent);
            //
            // if (!hasWon && nextContainsOpponent) {
            //   bbs.setState(() {
            //     bbs.widget.levels[position + 1].remove(opponent);
            //     bbs.widget.levels[position + 1].insert((j/2).floor(), team);
            //   });
            // }
            // else if (!hasWon && !nextContainsSelf && !nextContainsOpponent) {
            //   bbs.setState(() {
            //     bbs.widget.levels[position + 1].insert((j/2).floor(), team);
            //   });
            // }
            // else {
            //   return WinAndResetWidget(bbs.widget.levels);
            // }

            bbs.setState(() {
              // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
              bbs.widget.levels[position + 1].removeAt((j/2).floor());
              bbs.widget.levels[position + 1].insert((j/2).floor(), team);
              // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            });
          }
        ),
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
        color: Color.fromRGBO(50, 50, 50, 0.02),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.level.length,
          itemBuilder: (context, i) {
            print("Columns: ${widget.level.length}");
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.level[i].length,
                        itemBuilder: (context, j) {
                          print("Cards/Teams: ${widget.level[i].length}");
                          if (widget.level[i][j] == null)
                            return Container(
                              height: min(MediaQuery.of(context).size.height/2.55 / (widget.level[i].length*0.75), 75),
                              child: Card(),
                            );
                          else
                            return TeamCard(widget.level[i][j], widget.bbs, i, j);
                        },
                      ),
                    ),
                )
            );
          }, //itemBuilder
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
