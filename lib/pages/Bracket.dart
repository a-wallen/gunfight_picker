import 'package:flutter/material.dart';

import 'package:gunfight_picker/widgets/bracketbuilder.dart';
import 'package:gunfight_picker/widgets/inputForm.dart';

class Bracket extends StatefulWidget {
  @override
  _BracketState createState() => _BracketState();
}

class _BracketState extends State<Bracket> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: Column(
        children: [
          BracketBuilder(),
          InputForm(),
        ],
      ),
    );
  }
}
