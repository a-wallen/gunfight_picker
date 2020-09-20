import 'package:flutter/material.dart';
import 'package:gunfight_picker/pages/BracketPage.dart';

//import 'gamemaps.dart';
import 'functions/fetchMaps.dart';
import 'pages/HomePage.dart';
import 'package:gunfight_picker/theme/theme.dart';

Map jsonResponse;
String jsonEmptyError = "Call of Duty Modern Warfare maps could not be loaded.";

void main() {
  fetchMaps();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Gunfight Picker',
      theme: mw_theme,
      home: MyHomePage(title: 'Gunfight Picker'),
    );
  }
}

