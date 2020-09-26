//user will input D:H:M, I need to convert that
//Days >= 0, Days <= 365
//Hours: 0-23
//Minutes: 0-59
class Player {
  String name;
  double skill;

  Player(String playerName, String dhm) {
    //constructor
    //determine skill from hours
    name = playerName;
    skill = convertToMinutes(dhm);
  }

  Player.defaultConstructor() {
    name = "";
    skill = 0;
  }

  double convertToMinutes(String dhm) {
    return 0; //fill in later
  }

  String get getName {
    return name;
  }

  double get getSkill {
    return skill;
  }
}
