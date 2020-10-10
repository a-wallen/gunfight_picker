import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/classes/Player.dart';

//Matches players to a team, assuming team size = 2
//Does not match by skill, just matches in the order given in the input
List<Team> matchPlayers(List<Player> unmatchedPlayers, int teamSize) {
  print("fail 1");
  List<Team> teams = List<Team>((unmatchedPlayers.length / teamSize).ceil());
  print("fail 2");
  for (var team in teams) team.playerList = new List<Player>();

  int j = 0; //counter for unmatchedPlayers
  print("fail 2");
  for (int i = 0; i < unmatchedPlayers.length; i++) {
    /*for (int j = 0; j < unmatchedPlayers.length; j++) {
      teams[i].playerList.add(unmatchedPlayers[j]);
      teams[i].playerList.add(unmatchedPlayers[j + 1]);
    }*/
    print("fail 3");
    if (j < unmatchedPlayers.length) {
      //Each Team object contains a list of Players. So, a Team List is a nested List.
      //This adds the jth player to the ith team.
      teams[i].playerList.add(unmatchedPlayers[j]);
      j++;
      if (j < unmatchedPlayers.length) {
        teams[i].playerList.add(unmatchedPlayers[j]);
        j++;
      } else {
        print("All players have been added. \n");
      }
    } else {
      print("All players have been added.\n");
    }
  }
  return teams;
}
