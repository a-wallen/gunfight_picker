import 'package:flutter/material.dart';
import "dart:math";

import 'package:gunfight_picker/widgets/compassview.dart';
import 'package:gunfight_picker/main.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:gunfight_picker/theme/theme.dart';

List mapList = [];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(
            color: middle_green
          ),
        ),
      ),
      body: Column(
        children: [
          compassView(context),
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