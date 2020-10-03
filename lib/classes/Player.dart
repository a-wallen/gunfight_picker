import 'package:string_validator/string_validator.dart';

//user will input D:H:M, I need to convert that
//Days >= 0, Days <= 365
//Hours: 0-23
//Minutes: 0-59
class Player {
  String name;
  double kdratio;
  int skill;
  int hoursPlayed;

  // Player(String playerName, String kdratio, String dhm) {
  //   //constructor
  //   //determine skill from hours
  //   this.name = playerName;
  //   this.kdratio = double.parse(kdratio);
  //   this.skill = convertToMinutes(dhm);
  // }

  Player() {
    this.name = "Player Name";
    this.kdratio = 0.0;
    this.skill = 0;
    this.hoursPlayed = 0;
  }

  //precondition: dhm is in the format "Days: Hours: Minutes" with no other characters
  int convertToMinutes(String dhm) {
    List<String> list = dhm.split(":");
    List<int> intList;
    for (int i = 0; i < list.length; i++) {
      //converts each string (d, h, or m) to an int, then adds that int as an element to the int list
      intList.add(int.parse(list[i]));
    }
    //converts days and hours to minutes, then sums with minutes to get the total minutes
    return (intList[0] * 24 * 60 +
        intList[1] * 60 +
        intList[2]); //assumes intList.length = 3
    //source for split: https://www.tutorialkart.com/dart/dart-split-string/#:~:text=Dart%20Split%20String&text=You%20can%20split%20a%20string,split()%20method.&text=The%20function%20returns%20a%20list%20of%20strings
    //source for int.parse: https://bezkoder.com/dart-parse-string-to-double-int/
  }

  void set player_name(String name) {
    if (isAlpha(name)) this.name = name;
  }

  void set player_kdratio(String kd) {
    if (isFloat(kd)) this.kdratio = double.parse(kd);
  }

  void set player_hours(String hours) {
    if (isDate(hours)) this.hoursPlayed = 0;
  }

  void printPl() {
    print("Player hours: $getName");
    print("Player name: $getKD");
    print("Player kd: $getSkill");
  }

  String get getName {
    return name;
  }

  String get getKD {
    return name;
  }

  int get getSkill {
    return skill;
  }
}
