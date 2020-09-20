import 'package:flutter/material.dart';

import 'package:gunfight_picker/widgets/bracketbuilder.dart';
import 'package:gunfight_picker/widgets/inputForm.dart';

class BracketPage extends StatefulWidget {
  @override
  _BracketPageState createState() => _BracketPageState();
}

class _BracketPageState extends State<BracketPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      child: Column(
        children: [
          InputForm(),
          BracketBuilder(),
        ],
      ),
    );
  }
}
