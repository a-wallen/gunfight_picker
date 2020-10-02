import 'package:string_validator/string_validator.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'package:gunfight_picker/classes/Player.dart';
import 'package:flutter/material.dart';

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  List<Player> _players;
  ScrollController _scrollController;

  @override
  void initState() {
    _players = [Player(), Player(), Player()];
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height /
          2, // !!!!!!!!! mediaquery here !!!!!!!!!!
      // foregroundDecoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(25.0),
      //   // border: Border.all(color: Colors.black, width: 5.0,),
      // ),
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 500.0)]
      // ),
      child: Column(
        children: [
          Container(height: 10),
          Flexible(
            fit: FlexFit.loose,
            child: ListView.separated(
              controller: _scrollController,
              shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(5.0),
              itemCount: _players.length,
              separatorBuilder: (c, i) => Divider(
                thickness: 3.0,
                indent: 25,
                endIndent: 25,
              ),
              itemBuilder: (context, index) {
                return PlayerCard(this, _players[index]);
              }, //ItemBuilder
            ),
          ),
          AddPlayerButton(this),
        ],
      ),
    );
  }
}

class PlayerCard extends StatefulWidget {
  _InputFormState parent;
  Player player;
  PlayerCard(parent, player){
    this.parent = parent;
    this.player = player;
  }
  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {

  

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(widget.player),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        margin: EdgeInsets.all(5.0),
        color: lotion,
        elevation: 10.0,
        child: InkWell(
          // splashColor: Colors.amber,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return PlayerInputForm(this, widget.parent);
              },
            );
          },
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.donut_small,
                  color: dark_vanilla,
                  size: 45,
                ),
                title: Text(
                  widget.player.name,
                  style: TextStyle(color: davys_grey),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    skillDisplayField("rank", widget.player.getSkill.toString()),
                    skillDisplayField("kd ratio", widget.player.kdratio.toString()),
                    skillDisplayField("hours", widget.player.hoursPlayed.toString()),
                  ],
                ),
              ),
              Container(
                color: dark_vanilla,
                height: 10,
              ),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        widget.parent.setState(() {
          widget.parent._players.remove(widget.player);
        });
      },
    );
  }
}

class PlayerInputForm extends StatelessWidget {
  _InputFormState grandparent;
  _PlayerCardState parent;
  final _formKey = GlobalKey<FormState>();

  PlayerInputForm(this.parent, this.grandparent);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      title: Text(
        parent.widget.player.name,
        textAlign: TextAlign.center,
      ),
      elevation: 0.0,
      children: [
        Form(
          
          key: _formKey,
          child: Column(
            children: [
              myFormField("NAME", ValidatorType.STR),
              myFormField("KD RATIO", ValidatorType.DOUBLE),
              myFormField("HOURS", ValidatorType.DATE),
            ],
          ),
        ),
        FlatButton(
          //RaisedButton
          child: Text("ok"),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              grandparent.setState(() {
                grandparent._players[0] = "50";
              });
              parent.setState(() {
                parent.widget.player.player_name = "Ezra";
                parent.widget.player.player_hours = "24";
                parent.widget.player.player_kdratio = "1.0";
              });
              for(int i = 0; i < grandparent._players.length; i++){
                grandparent._players[i].printPl();
              }
              Navigator.of(context).pop();
            }
          }, //use grandparent here
        ),
      ],
    );
  }
}

class AddPlayerButton extends StatelessWidget {
  _InputFormState parent;

  AddPlayerButton(this.parent);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // decoration: BoxDecoration(border: Border.all()),
        child: //Ink(
            // decoration: ShapeDecoration(
            //   color: Colors.lightGreen,
            //   shape: CircleBorder(),
            // ),
            /*child:*/ IconButton(
          icon: Icon(Icons.group_add),
          color: Colors.black45,
          splashColor: Colors.lightGreen,
          iconSize: 40,
          onPressed: () {
            parent.setState(() {
              parent._players.add(Player());
              parent._scrollController.animateTo(
                1000,
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeIn,
              );
            });
          },
          //),
        ),
      ),
    );
  }
}

enum ValidatorType {
  STR,
  DOUBLE,
  DATE,
}

String myFormValidator(String value, ValidatorType vt) {
  if (value.isEmpty) return "This field cannot be empty.";
  if (vt == ValidatorType.STR && !isAlpha(value))
    return "Input is invalid name.";
  if (vt == ValidatorType.DOUBLE && !isFloat(value))
    return "Input must be ratio.";
  if (vt == ValidatorType.DATE && !isDate(value)) return "Input must be a date";
  return null;
}

Widget myFormField(String fieldName, ValidatorType vt) {
  return Container(
      margin: EdgeInsets.all(5.0),
      child: TextFormField(
          //validator: (input) => myFormValidator(input, vt),
          validator: (input) => myFormValidator(input, vt),
          style: TextStyle(
            fontFamily: "Lato",
          ),
          decoration: InputDecoration(
            labelText: fieldName,
            contentPadding: EdgeInsets.all(5.0),
          )));
}

Widget skillDisplayField(String attributeName, String skillQty) {
  return Column(
    children: [
      Text(
        attributeName,
        textScaleFactor: 0.8,
      ),
      Text(
        skillQty,
        style: TextStyle(
          fontFamily: "Lato",
        ),
      ),
    ],
  );
}
// class Player {
//   String name;
//   double kdratio;
//   double hoursplayed;

//   Player(int i) {
//     name = "Player " + i.toString();
//     kdratio = 0.0;
//     hoursplayed = 0.0;
//   }
// }
