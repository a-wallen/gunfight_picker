import 'package:flutter/material.dart';

import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'MapPicker.dart';
import 'BracketPage.dart';

class MyHomePage extends StatefulWidget {
  //constructor
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _navBarIndex = 0;

  static List<Widget> _pages = <Widget>[
    MapPickerPage(),
    BracketPage(),
  ];
  
  @override
  void initState() {
    fetchMaps().then((value) {
      print("Json Response Fetched");
    });
    super.initState();
  }

  void _onNavBarTap(int index) {
    setState(() {
      _navBarIndex = index;
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
