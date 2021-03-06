import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/HomePage.dart';
import 'package:gunfight_picker/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Gunfight Picker',
      theme: mw_theme,
      home: MyHomePage(title: 'Gunfight Picker'),
    );
  }
}
