import 'dart:math';
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
    _players = [Player(1), Player(2), Player(3)];
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
      height: 400, // !!!!!!!!! mediaquery here !!!!!!!!!!
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


class PlayerCard extends StatelessWidget {
  _InputFormState parent;
  Player player;

  PlayerCard(this.parent, this.player);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(player),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        margin: EdgeInsets.all(5.0),
        color: Colors.lightGreen,
        elevation: 10.0,
        child: InkWell(
          // splashColor: Colors.amber,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return PlayerInputForm(this, this.parent);
              },
            );
          },
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.donut_small, size: 45,),
                title: Text(player.name),
                subtitle: Row(
                  children: [
                    Text("rank        ", textScaleFactor: 0.8,),
                    Text("k/d          ", textScaleFactor: 0.8,),
                    Text("hours ingame", textScaleFactor: 0.8,),
                  ],
                ),
              ),
              Container(height: 50,),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        parent.setState(() { parent._players.remove(player); });
      },
    );
  }
}


class PlayerInputForm extends StatelessWidget {
  _InputFormState grandparent;
  PlayerCard parent;

  PlayerInputForm(this.parent, this.grandparent);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0)
        ),
      ),
      title: Text(parent.player.name),
      elevation: 0.0,
      children: [
        Form(
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(labelText: "rank")),
              TextFormField(initialValue: parent.player.kdratio.toString(),),
              TextFormField(decoration: InputDecoration(hintText: "hours ingame")),
            ],
          ),
        ),
        FlatButton( //RaisedButton
          child: Text("ok"),
          onPressed: () { Navigator.of(context).pop(); }, //use grandparent here
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
              parent._players.add(Player(parent._players.length+1));
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


class Player {
  String name;
  double kdratio;
  double hoursplayed;

  Player(int i) {
    name = "Player " + i.toString();
    kdratio = 0.0;
    hoursplayed = 0.0;
  }
}