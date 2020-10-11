import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/pages/BracketPage.dart';
import 'package:gunfight_picker/classes/Player.dart';
import 'package:gunfight_picker/data/militaryAlphabet.dart';

// import matching teams to get teams.length

class BracketBuilder extends StatefulWidget {
  List<List<Team>> levels;
  List<Team> _teams;

  BracketBuilder(List<Team> tl) {
    this._teams = tl;
    // this._teams = [
    //   Team(),
    //   Team(),
    // ];
    // Hardcode  = [Team(), Team()] to test Andrew, Ezra, Hector Widget
    if (_teams.isNotEmpty) {
      this.levels = List<List<Team>>((log(_teams.length) / log(2)).ceil() + 1);
      levels[0] = _teams;
      for (int i = 1; i < levels.length; i++)
        levels[i] = List<Team>()..length = (levels[i - 1].length / 2).ceil();
    } else {
      this.levels = List<List<Team>>();
    }
  }
  @override
  _BracketBuilderState createState() => _BracketBuilderState();
}

class _BracketBuilderState extends State<BracketBuilder> {
  void resetLevels() {
    // for (int i = 0; i < widget.levels.length; i++) {
    //   while (widget.levels[i].isNotEmpty) widget.levels[i].removeAt(0);
    //   widget.levels.removeAt(0);
    // }
    setState(() {
      widget.levels = List<List<Team>>();
    });
    print("LEVELS SIZE: ${widget.levels.isEmpty}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.3,
      child: switchDisplayChildBasedOnListSize(this),
    );
  }
}

//super long name for explanation
Widget switchDisplayChildBasedOnListSize(_BracketBuilderState bbs) {
  if (bbs.widget.levels.isEmpty)
    return NoTeamsWidget();
  else if (bbs.widget.levels[bbs.widget.levels.length - 1][0] != null) {
    print("SIZE: ${bbs.widget.levels.length}");
    return WinAndResetWidget(bbs);
  } else
    return AndrewAndEzraWidget(bbs.widget.levels, bbs);
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
      height: min(
          MediaQuery.of(context).size.height /
              2.55 /
              (bbs.widget.levels[position].length),
          75),
      child: Card(
        elevation: 2.0,
        child: ListTile(
            trailing: Icon(
              Icons.circle,
              color: this.team.getTeamColor,
              size: 10,
            ),
            title: Text(
              "${this.team.getTeamName}",
              style: TextStyle(fontSize: 16),
            ),
            subtitle: this.team.getPlayerList.length == 1
                ? Text(
                    "${this.team.getPlayerList[0].getName}",
                    style: TextStyle(fontSize: 8),
                  )
                : Text(
                    "${this.team.getPlayerList[0].getName}\n${this.team.getPlayerList[1].getName}",
                    style: TextStyle(fontSize: 8),
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
              bool hasWon = position + 1 == bbs.widget.levels.length;

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
                bbs.widget.levels[position + 1].removeAt((j / 2).floor());
                bbs.widget.levels[position + 1].insert((j / 2).floor(), team);
                // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
              });
            }),
      ),
    );
  }
}

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
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        if (index % 2 == 1)
                          return Divider(
                            thickness: 3.0,
                            indent: 25,
                            endIndent: 25,
                          );
                        else
                          return Divider(
                            height: 0,
                            color: lotion,
                          );
                      },
                      shrinkWrap: true,
                      itemCount: widget.level[i].length,
                      itemBuilder: (context, j) {
                        print("Cards/Teams: ${widget.level[i].length}");
                        if (widget.level[i][j] == null)
                          return Container(
                            height: min(
                                MediaQuery.of(context).size.height /
                                    2.55 /
                                    (widget.level[i].length * 0.75),
                                75),
                            child: Card(),
                          );
                        else
                          return TeamCard(widget.level[i][j], widget.bbs, i, j);
                      },
                    ),
                  ),
                ));
          }, //itemBuilder
        ));
  }
}

class WinAndResetWidget extends StatefulWidget {
  _BracketBuilderState bbs;

  WinAndResetWidget(_BracketBuilderState b) {
    this.bbs = b;
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
                  "${widget.bbs.widget.levels[widget.bbs.widget.levels.length - 1].elementAt(0).getTeamName}",
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
                    widget.bbs.resetLevels();
                    print(
                        "Is levels empty? ${widget.bbs.widget.levels.isEmpty}");
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
