import "dart:async";
import "dart:math";
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//import 'gamemaps.dart';
import 'widgets/compassviewchild.dart';

Map jsonResponse;
String jsonEmptyError = "Call of Duty Modern Warfare maps could not be loaded.";

fetchMaps() async {
  String apiUrl =
      "https://my.callofduty.com/api/papi-client/ce/v1/title/mw/platform/battle/gameType/mp/communityMapData/availability";
  var response = await http.get(apiUrl);
  if (response.statusCode == 200) {
    jsonResponse = convert.jsonDecode(response.body);
    jsonResponse = jsonResponse["data"];
    print(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

void main() {
  fetchMaps();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'MW',
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
      if(value.contains(gamemode)){
        _possibleMaps.add(key);
      }
    });

   
    setState(() {
      gameMap = _possibleMaps[rng.nextInt(_possibleMaps.length-1)];
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(gameMap)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pickMap(gamemode),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

