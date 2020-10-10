import 'package:flutter/material.dart';

import 'package:string_validator/string_validator.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/classes/Player.dart';
import 'package:gunfight_picker/functions/balancingteams.dart';
import 'package:gunfight_picker/functions/matchingPlayers.dart';

class InputForm extends StatefulWidget {
  List<Player> _players;
  List<Team> _teams;
  @override
  InputForm(List<Player> pl, List<Team> tl) {
    this._players = pl;
    this._teams = tl;
  }
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ListView.separated(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: widget._players.length,
              separatorBuilder: (c, i) => Divider(
                thickness: 3.0,
                indent: 25,
                endIndent: 25,
              ),
              itemBuilder: (context, index) {
                return PlayerCard(this, widget._players[index]);
              }, //ItemBuilder
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: IconButton(
                  icon: Icon(Icons.group_add),
                  color: Colors.black45,
                  splashColor: Colors.lightGreen,
                  iconSize: 40,
                  onPressed: () {
                    setState(() {
                      widget._players.add(Player());
                      _scrollController.animateTo(
                        1000,
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.easeIn,
                      );
                    });
                  },
                  //),
                ),
              ),
              Container(
                child: IconButton(
                  onPressed: () {
                    print("Players: ${widget._players}");
                    print("Teams: ${widget._teams}");
                    setState(() {
                      widget._teams = matchPlayers(widget._players, 2);
                      // widget._teams = balanceTeams(widget._teams);
                    });
                    for (var player in widget._players) {
                      player.printPl();
                    }
                    for (var team in widget._teams) {
                      for (var player in team.playerList) player.printPl();
                    }
                  },
                  icon: Icon(Icons.check_box),
                  color: Colors.black45,
                  splashColor: Colors.lightGreen,
                  iconSize: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlayerCard extends StatefulWidget {
  _InputFormState parent;
  Player player;
  PlayerCard(parent, player) {
    this.parent = parent;
    this.player = player;
  }
  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(widget.player),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        margin: EdgeInsets.all(5.0),
        color: lotion,
        elevation: 10.0,
        child: InkWell(
          // splashColor: Colors.amber,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return PlayerInputForm(this, widget.parent);
              },
            );
          },
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.donut_small,
                  color: dark_vanilla,
                  size: 45,
                ),
                title: Text(
                  widget.player.name,
                  style: TextStyle(color: davys_grey),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    skillDisplayField(
                        "rank", widget.player.getSkill.toString()),
                    skillDisplayField(
                        "kd ratio", widget.player.kdratio.toString()),
                    skillDisplayField(
                        "hours", widget.player.hoursPlayed.toString()),
                  ],
                ),
              ),
              Container(
                color: dark_vanilla,
                height: 10,
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        widget.parent.setState(() {
          widget.parent.widget._players.remove(widget.player);
        });
      },
    );
  }
}

class PlayerInputForm extends StatelessWidget {
  _InputFormState grandparent;
  _PlayerCardState parent;
  final _formKey = GlobalKey<FormState>();

  PlayerInputForm(this.parent, this.grandparent);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      title: Text(
        parent.widget.player.name,
        textAlign: TextAlign.center,
      ),
      elevation: 0.0,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              myFormField("NAME", ValidatorType.STR, this.parent),
              myFormField("KD RATIO", ValidatorType.DOUBLE, this.parent),
              myFormField("HOURS", ValidatorType.INT, this.parent),
            ],
          ),
        ),
        FlatButton(
          //RaisedButton
          child: Text("ok"),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              for (int i = 0; i < grandparent.widget._players.length; i++) {
                grandparent.widget._players[i].printPl();
              }
              Navigator.of(context).pop();
            }
          }, //use grandparent here
        ),
      ],
    );
  }
}

// class AddPlayerButton extends StatelessWidget {
//   _InputFormState parent;

//   AddPlayerButton(this.parent);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         // decoration: BoxDecoration(border: Border.all()),
//         child: //Ink(
//             // decoration: ShapeDecoration(
//             //   color: Colors.lightGreen,
//             //   shape: CircleBorder(),
//             // ),
//             /*child:*/ IconButton(
//           icon: Icon(Icons.group_add),
//           //color: Colors.black45,
//           //splashColor: Colors.lightGreen,
//           iconSize: 40,
//           onPressed: () {
//             parent.setState(() {
//               parent.widget._players.add(Player());
//               parent._scrollController.animateTo(
//                 1000,
//                 duration: Duration(milliseconds: 1000),
//                 curve: Curves.easeIn,
//               );
//             });
//           },
//           //),
//         ),
//       ),
//     );
//   }
// }

enum ValidatorType {
  STR,
  DOUBLE,
  INT,
}

String myFormValidator(String value, ValidatorType vt) {
  if (value.isEmpty) return "This field cannot be empty.";
  if (vt == ValidatorType.STR && !isAlpha(value))
    return "Input is invalid name.";
  if (vt == ValidatorType.DOUBLE && !isFloat(value))
    return "Input must be ratio.";
  if (vt == ValidatorType.INT && !isInt(value)) return "Input must be a date";
  return null;
}

Widget myFormField(
    String fieldName, ValidatorType vt, _PlayerCardState parent) {
  return Container(
      margin: EdgeInsets.all(5.0),
      child: TextFormField(
          onSaved: (input) {
            if (vt == ValidatorType.INT) {
              parent.widget.player.player_hours = input;
              parent.setState(() {});
            } else if (vt == ValidatorType.DOUBLE) {
              parent.setState(() {
                parent.widget.player.player_kdratio = input;
              });
            } else if (vt == ValidatorType.STR) {
              parent.setState(() {
                parent.widget.player.player_name = input;
              });
            }
          },
          keyboardType:
              fieldName == "NAME" ? TextInputType.text : TextInputType.number,
          // initialValue: player.name,
          //validator: (input) => myFormValidator(input, vt),
          validator: (input) => myFormValidator(input, vt),
          style: TextStyle(
            fontFamily: "Lato",
          ),
          decoration: InputDecoration(
            labelText: fieldName,
            contentPadding: EdgeInsets.all(5.0),
          )));
}

Widget skillDisplayField(String attributeName, String skillQty) {
  return Column(
    children: [
      Text(
        attributeName,
        textScaleFactor: 0.8,
      ),
      Text(
        skillQty,
        style: TextStyle(
          fontFamily: "Lato",
        ),
      ),
    ],
  );
}
