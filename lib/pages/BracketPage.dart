import 'package:flutter/material.dart';
import 'package:gunfight_picker/functions/matchingPlayers.dart';
import 'package:gunfight_picker/functions/balancingteams.dart';
import 'package:gunfight_picker/theme/theme.dart';

import 'package:gunfight_picker/widgets/bracketbuilder.dart';
import 'package:gunfight_picker/widgets/inputForm.dart';
import 'package:gunfight_picker/classes/Player.dart';
import 'package:gunfight_picker/classes/Team.dart';

class BracketPage extends StatefulWidget {
  @override
  _BracketPageState createState() => _BracketPageState();
}

class _BracketPageState extends State<BracketPage> {
  @override
  List<Team> teams = [];
  List<Player> players = [Player(), Player(), Player()];
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      child: Column(
        children: [
          InputForm(players),
          FlatButton(
              color: dark_vanilla,
              onPressed: () {
                setState(() {
                  teams = matchPlayers(players);
                  teams = balanceTeams(teams);
                });
                for (var player in players) {
                  player.printPl();
                }
                for (var team in teams) {
                  for (var player in team.playerList) player.printPl();
                }
              },
              child: Text(
                "Ready Up",
                style: TextStyle(fontFamily: 'MW'),
              )),
          BracketBuilder(teams),

          /// n = 4
        ],
      ),
    );
  }
}
