import "package:gunfight_picker/classes/Player.dart";
import 'package:flutter/material.dart';
import 'dart:math';

class Team {
  String teamName;
  Color teamColor;
  List<Player> playerList;
  double aggregateSkill;

  //double skill = player1.getSkill() + player2.getSkill();
  Team() {
    var random = new Random();
    teamColor = Colors.primaries[random.nextInt(Colors.primaries.length)];
    List<Player> playerList = List<Player>();
    aggregateSkill = computeAggregateSkill(playerList);
    teamName = "Alpha";
    print("team constructor was called");
  }

  double computeAggregateSkill(List<Player> myPlayerList) {
    double result = 0;
    for (var player in myPlayerList) result += player.getSkill;
    return result;
  }

  Color get getTeamColor {
    return this.teamColor;
  }

  String get getTeamName {
    return this.teamName;
  }

  List<Player> get getPlayerList {
    return this.playerList;
  }
}
