import "package:gunfight_picker/classes/Player.dart";

class Team {
  String teamName;
  List<Player> playerList;
  double aggregateSkill;

  //double skill = player1.getSkill() + player2.getSkill();
  Team() {
    List<Player> playerList = List<Player>();
    aggregateSkill = computeAggregateSkill(playerList);
    teamName = "";
    print("team constructor was called");
  }

  double computeAggregateSkill(List<Player> myPlayerList) {
    double result = 0;
    for (var player in myPlayerList) result += player.getSkill;
    return result;
  }

  List<Player> get getPlayerList {
    return this.playerList;
  }
}
