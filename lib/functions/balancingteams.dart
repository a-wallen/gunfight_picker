import 'dart:math';
import 'package:gunfight_picker/classes/Team.dart';

/*matches teams based on aggregate skill: 
  best to worst, second-best to second-worst, etc.
  ONLY HANDLES THE CASE WITH AN EVEN NUMBER OF TEAMS*/
List balanceTeams(List<Team> unmatchedTeams) {
  List matchedTeams;
  /*sort teams by aggregate skill, lowest to highest, using the Dart sort() fumction
    source for sort(): typed it into Dart and it showed the sort() function
    check if I sorted in the right order. Does it matter?*/
  unmatchedTeams.sort((a, b) => a.aggregateSkill.compareTo(b.aggregateSkill));
  //match highest to lowest, next highest to next lowest, etc.
  int i = 0; //index for matchedTeams
  //check condition of loop...
  while (unmatchedTeams.length > 0) {
    //inserts the lowest-skilled team into matchedTeams at index i
    matchedTeams[i] = unmatchedTeams[0];
    //removes the lowest-skill team from unmatchedTeams
    unmatchedTeams.remove(unmatchedTeams[0]);
    /*inserts the highest-skilled team at index i + 1 of matchedTeams,
      thus matching it with the lowest-skilled team*/
    matchedTeams[i + 1] = unmatchedTeams[unmatchedTeams.length - 1];
    //removes the highest-skilled team from unmatchedTeams
    unmatchedTeams.remove(unmatchedTeams[unmatchedTeams.length - 1]);
    i++;
  }
  //Handles the case where the number of teams is odd, and therefore,
  //the middle team remains in unmatchedTeams.
  /*if (unmatchedTeams.length > 0) {
    //in other words, if unmatchedTeams.length == 1
    matchedTeams.add(unmatchedTeams[0]);
    //adds middle team to end of matchedTeams, matching it with the two teams
    //that are the closest to it (above and below) in skill level.
  }*/
  return matchedTeams;
}

//match teams randomly, not based on skill
//so far, only handles the case where the number of teams is even
//I don't know what to import so I can generate a random number
List matchTeamsRandomly(List<Team> unmatchedTeams) {
  List matchedTeams;
  //this will be the random number of the team that gets matched to the team at index i
  //THIS VALUE IS TEMPORARY UNTIL I FIGURE OUT RANDOM NUMBER GENERATION
  int randInt = unmatchedTeams.length - 1;
  int i = 0; //index of matchedTeams
  if (matchedTeams.length % 2 == 0) //even number of teams
    while (matchedTeams.length > 0) {
      //generating a random double in range 0 to unmatchedTeams.length - 1:
      //range = max - min + 1, source: AP Computer Science A notes
      double randDouble; // = math.random() * unmatchedTeams.length;
      //casting to int to create a random index in unmatchedTeams:
      randInt = randDouble as int;
      matchedTeams[i] = unmatchedTeams[0];
      matchedTeams[i + 1] = unmatchedTeams[randInt];
      unmatchedTeams.remove(unmatchedTeams[0]);
      unmatchedTeams.remove(unmatchedTeams[randInt]);
      i++; //move to next index in matchedTeams
      return matchedTeams;
    }
  return matchedTeams;
}
