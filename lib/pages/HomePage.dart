import 'package:flutter/material.dart';
import "dart:math";

import 'package:gunfight_picker/widgets/compassview.dart';
import 'package:gunfight_picker/main.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:gunfight_picker/theme/theme.dart';

List mapList = [];

class MyHomePage extends StatefulWidget {
  //constructor
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String gamemode = "cyber"; // gunfight
  String gameMap = "Shake the screen to get a random map.";
  
  _pickMap(String gamemode) async {
    //emphasis on error checking
    assert(gamemode.isNotEmpty);
    if (jsonResponse == null) await fetchMaps();

    final Random rng = Random();
    List _possibleMaps = [];
  // bad comment
    jsonResponse.forEach((key, value) {
      print(key);
      if (value.contains(gamemode)) {
        _possibleMaps.add(key);
      }
    });

    setState(() {
      gameMap = _possibleMaps[rng.nextInt(_possibleMaps.length - 1)];
      // String temp = codeToMapName(gameMap);
      print("The map you got was: $gameMap");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: middle_green),
        ),
      ),
      body: Column(
        children: [
          compassView(context),
          Image(
              image: NetworkImage(
                  "https://clgraphics.files.wordpress.com/2013/05/picture.gif")
                  ),
          Text(gameMap),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickMap(gamemode),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
