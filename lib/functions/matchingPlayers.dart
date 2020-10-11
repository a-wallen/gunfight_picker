import 'package:gunfight_picker/classes/Team.dart';
import 'package:gunfight_picker/classes/Player.dart';
import 'package:gunfight_picker/data/militaryAlphabet.dart';

// matches players to teams, assuming team size is 2

List<Team> matchPlayers(List<Player> unmatchedPlayers, int teamSize) {
  List<Team> teams = List<Team>((unmatchedPlayers.length / teamSize).ceil());

  // calculate skill of each player (KD * hours)

  int currentSkill;

  for (int i = 0; i < unmatchedPlayers.length; i++) {
    currentSkill =
        (unmatchedPlayers[i].getKD * unmatchedPlayers[i].getHours).round();
    unmatchedPlayers[i].skill = currentSkill;

    print("Player $i skill is $currentSkill");
  }

  // sort players by skill from lowest to highest using bubble sort

  int i;
  int j;
  Player temp;

  for (i = 0; i < unmatchedPlayers.length - 1; i++) {
    for (j = 0; j < unmatchedPlayers.length - i - 1; j++) {
      if (unmatchedPlayers[j].getSkill > unmatchedPlayers[j + 1].getSkill) {
        temp = unmatchedPlayers[j];
        unmatchedPlayers[j] = unmatchedPlayers[j + 1];
        unmatchedPlayers[j + 1] = temp;
      }
    }
  }

  print("Skills sorted from lowest to highest:");

  for (int i = 0; i < unmatchedPlayers.length; i++) {
    print(unmatchedPlayers[i].getSkill);
  }

  // initialize all team and player lists

  for (int i = 0; i < teams.length; i++) {
    teams[i] = new Team();
    teams[i].playerList = new List<Player>();
  }

  // algorithm for matching players to teams

  int front; // counter starting from least-skilled player (front of unmatchedPlayers)
  int back; // counter starting from most-skilled player (back of unmatchedPlayers)
  int k; // counter for while loops, i and j have already been used :(

  // runs if unmatchedPlayers contains an even number of players
  if (unmatchedPlayers.length % 2 == 0) {
    front = 0;
    back = unmatchedPlayers.length - 1;
    k = 0;

    // prevents counters from overlapping
    while (front < (unmatchedPlayers.length / 2)) {
      teams[k].playerList.add(unmatchedPlayers[front]);
      teams[k].playerList.add(unmatchedPlayers[back]);

      front++;
      back--;
      k++;
    }

    print("All players have been put into to teams of two.");
  }
  // runs if unmatchedPlayers contains an odd number of players
  else {
    front = 0;
    back = unmatchedPlayers.length -
        2; // reserves most skilled player to be on a team by theirself
    k = 0;

    while (front < ((unmatchedPlayers.length - 1) / 2)) {
      teams[k].playerList.add(unmatchedPlayers[front]);
      teams[k].playerList.add(unmatchedPlayers[back]);

      front++;
      back--;
      k++;
    }

    // at this point all players have been put into teams except for the most skilled player
    // so we need to put the most skilled player on a team by theirself
    teams[k].playerList.add(unmatchedPlayers[unmatchedPlayers.length - 1]);

    print(
        "There is an odd number of players, so the most skilled player has been put on a team by theirself.");
  }

  for (int i = 0; i < teams.length; i++) {
    teams[i].teamName = militaryAlphabet[(i % militaryAlphabet.length)];
    print(teams[i].teamName);
  }

  return teams;
}
