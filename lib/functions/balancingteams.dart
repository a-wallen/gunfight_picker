import 'package:gunfight_picker/classes/Team.dart';

/*matches teams based on aggregate skill: 
  best to worst, second-best to second-worst, etc.*/
List balanceTeams(List<Team> unmatchedTeams) {
  List matchedTeams;
  /*sort teams by aggregate skill, lowest to highest, using the Dart sort() fumction
    source for sort(): typed it into Dart and it showed the sort() function
    check if I sorted in the right order. Does it matter?*/
  unmatchedTeams.sort((a, b) => a.aggregateSkill.compareTo(b.aggregateSkill));
  //match highest to lowest, next highest to next lowest, etc.
  int i = 0; //index for Lists
  while (unmatchedTeams.length > 1) {
    //check condition
    //inserts the lowest-skilled team into matchedTeams at index i
    matchedTeams[i] = unmatchedTeams[0];
    //removes the lowest-skill team from unmatchedTeams
    unmatchedTeams.remove(unmatchedTeams[0]);
    //inserts the highest-skilled team at index i + 1 of matchedTeams, thus matching it with the lowest-skilled team
    matchedTeams[i + 1] = unmatchedTeams[unmatchedTeams.length - i];
    //removes the highest-skill team from unmatchedTeams
    unmatchedTeams.remove(unmatchedTeams[unmatchedTeams.length - i]);
    i++;
  }
  return matchedTeams;
}

//match teams randomly, not based on skill
List matchTeamsRandomly(List<Team> teams) {
  return teams;
}
