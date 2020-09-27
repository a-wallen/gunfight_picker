import "dart:math";

import 'package:flutter/material.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'package:gunfight_picker/widgets/compassview.dart';
import 'package:gunfight_picker/data/codeToImage.dart';
import 'package:gunfight_picker/data/codeToName.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';

class MapPickerPage extends StatefulWidget {
  @override
  _MapPickerPageState createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {

  String gamemode = "cyber"; // gunfight
  String gameMap = "mp_cave_am";

  void _pickMap(String gamemode) async {
    //emphasis on error checking
    assert(gamemode.isNotEmpty);
    if (jsonResponse == null) await fetchMaps();

    final Random rng = Random();
    List _possibleMaps = [];
    // bad comment
    jsonResponse.forEach((key, value) {
      if (value.contains(gamemode)) {
        _possibleMaps.add(key);
      }
    });

    setState(() {
      gameMap = _possibleMaps[rng.nextInt(_possibleMaps.length - 1)];
    });
  }

  Widget mapPicker() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    width: 320.0,
                    height: 180.0,
                    child: codeToMapImage[gameMap],
                  ),
                ),
                Text(
                  codeToMap[gameMap],
                ),
              ],
            ),
          ),
          FlatButton(
              onPressed: () => _pickMap(gamemode),
              textColor: lotion,
              color: middle_green,
              child: Text('Random Map')),
          Text("Compass"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mapPicker(),
        ],
      ),
    );
  }
}
