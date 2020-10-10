import "package:gunfight_picker/classes/Player.dart";

class Team {
  List<Player> playerList;
  double aggregateSkill;

  //double skill = player1.getSkill() + player2.getSkill();
  Team() {
    List<Player> playerList = List<Player>();
    aggregateSkill = computeAggregateSkill(playerList);
  }

  double computeAggregateSkill(List<Player> myPlayerList) {
    double result = 0;
    for (int i = 0; i < myPlayerList.length; i++) {
      result += myPlayerList[i].getSkill;
    }
    return result;
  }

  List<Player> get getPlayerList {
    return playerList;
  }
}
