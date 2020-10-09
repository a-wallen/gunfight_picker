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
  double foregroundElevation = 10.0;
  PageController _pageController = PageController(initialPage: 0);

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavBarTap(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  _onPageChanged(int i) {
    setState(() {
      _navBarIndex = _pageController.page.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: foregroundElevation,
        title: Text(
          widget.title,
          style: TextStyle(color: middle_green),
        ),
      ),
      body: Container(
        //margin: EdgeInsets.all(10.0),
        //width: MediaQuery.of(context).size.width,
        // child: _pages.elementAt(_navBarIndex)
        child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: foregroundElevation,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            // label: "Maps",
            title: Text("Maps"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            // label: "Brackets",
            title: Text("Brackets"),
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
