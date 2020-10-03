import 'package:gunfight_picker/classes/Player.dart';

/*matches players based on aggregate skill: 
  best to worst, second-best to second-worst, etc.
  ONLY HANDLES THE CASE WITH AN EVEN NUMBER OF PLAYERS*/
List matchPlayers(List<Player> unmatchedPlayers) {
  List matchedPlayers;
  /*sort players by aggregate skill, lowest to highest, using the Dart sort() fumction
    source for sort(): typed it into Dart and it showed the sort() function
    check if I sorted in the right order. Does it matter?*/
  unmatchedPlayers.sort((a, b) => a.getSkill.compareTo(b.getSkill));
  //match highest to lowest, next highest to next lowest, etc.
  int i = 0; //index for matchedPlayers
  //check condition of loop...
  while (unmatchedPlayers.length > 0) {
    //inserts the lowest-skilled player into matchedplayers at index i
    matchedPlayers[i] = unmatchedPlayers[0];
    //removes the lowest-skill player from unmatchedPlayers
    unmatchedPlayers.remove(unmatchedPlayers[0]);
    /*inserts the highest-skilled player at index i + 1 of matchedplayers,
      thus matching it with the lowest-skilled player*/
    matchedPlayers[i + 1] = unmatchedPlayers[unmatchedPlayers.length - 1];
    //removes the highest-skilled player from unmatchedPlayers
    unmatchedPlayers.remove(unmatchedPlayers[unmatchedPlayers.length - 1]);
    i++;
  }
  //Handles the case where the number of players is odd, and therefore,
  //the middle player remains in unmatchedPlayers.
  /*if (unmatchedPlayers.length > 0) {
    //in other words, if unmatchedPlayers.length == 1
    matchedplayers.add(unmatchedPlayers[0]);
    //adds middle player to end of matchedplayers, matching it with the two players
    //that are the closest to it (above and below) in skill level.
  }*/
  return matchedPlayers;
}
