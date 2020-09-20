import "dart:math";
import 'package:flutter/material.dart';

import 'package:gunfight_picker/main.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'MapPicker.dart';
import 'BracketPage.dart';

List mapList = [];

class MyHomePage extends StatefulWidget {
  //constructor
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _navBarIndex = 0;
  String gamemode = "cyber"; // gunfight
  String gameMap = "mp_cave_am";

  static List<Widget> _pages = <Widget>[
    MapPickerPage(),
    BracketPage(),
  ];
  
  void _onNavBarTap(int index) {
    setState(() {
      _navBarIndex = index;
    });
  }
  void _pickMap(String gamemode) async {
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
      body: Container(
        margin: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        child: _pages.elementAt(_navBarIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Maps",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Brackets",
          ),
        ],
        currentIndex: _navBarIndex,
        selectedItemColor: middle_green,
        onTap: _onNavBarTap,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _pickMap(gamemode),
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
