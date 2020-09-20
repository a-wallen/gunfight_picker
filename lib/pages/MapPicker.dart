import 'package:flutter/material.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'package:gunfight_picker/widgets/MapImage.dart';
import "dart:math";

import 'package:gunfight_picker/widgets/compassview.dart';
import 'package:gunfight_picker/data/codeToImage.dart';
import 'package:gunfight_picker/data/codeToName.dart';
import 'package:gunfight_picker/main.dart';
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

  Widget mapPickerNameButton() {
    return Container(
      child: Column(
        children: [
          Text(
            codeToMap[gameMap],
          ),
          FlatButton(
              onPressed: () => _pickMap,
              textColor: lotion,
              color: middle_green,
              child: Text('Random Map')),
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
          //CompassView(),
          // Image(
          //   image: codeToMapImage["mp_cave_am"],
          // ),
          mapPickerNameButton(),
        ],
      ),
    );
  }
}
