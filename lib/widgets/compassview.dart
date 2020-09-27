import 'package:flutter/material.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:gunfight_picker/data/codeToImage.dart';
import 'package:gunfight_picker/data/codeToName.dart';
import 'package:gunfight_picker/theme/theme.dart';

class CompassView extends StatefulWidget {
  @override
  _CompassViewState createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {

  // void initState() {
  //   makeGameModeList().then((value) {
  //     print("Json Response Fetched");
  //   });
  //   super.initState();
  // }

  Widget compassItem(String mode) {
    return FlatButton(
        onPressed: null,
        child: Column(
          children: [
            Icon(Icons.arrow_upward),
            Text(mode),
          ],
        ));
  }

  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 400.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: gameModeList.length,
        itemBuilder: (context, index) {
          return compassItem(gameModeList[index]);
        },
      ),
    );
  }
}

// IconButton(
//                 icon: Icon(Icons.arrow_left),
//                 onPressed: () => aarowNaviateOnPressed(-1),
//               ),

//               IconButton(
//                 icon: Icon(Icons.arrow_right),
//                 onPressed: () => aarowNaviateOnPressed(1),
//               ),
