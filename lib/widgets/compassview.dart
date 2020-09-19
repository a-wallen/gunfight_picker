import 'package:flutter/material.dart';
import 'package:gunfight_picker/theme/theme.dart';

class CompassView extends StatefulWidget {
  @override
  _CompassViewState createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  @override
  List tempMaps = [
    "Cyber Attack",
    "Gunfight",
    "Search & Destroy",
    "Infected",
    "Shoot the Ship"
  ];
  int index = 0;

  void aarowNaviateOnPressed(int direction) {
    index += direction;
    if (index < 0) index = tempMaps.length - 1;
    if (index > tempMaps.length) index = 0;
    print(index);
    print(tempMaps[index]);
  }

  Widget compassItem(String str, int i) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,    
        children: [
         Icon(Icons.arrow_upward),
          Text(
            str,
          ),
        ],
      ),
    );
  }

  Widget compass() {
    return Row(
      children: [
        compassItem(tempMaps[index], index),
        compassItem(tempMaps[index + 1], index),
        compassItem(tempMaps[index + 2], index),
      ],
    );
  }

  Widget build(BuildContext context) {

    double length = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: length / 8,
        color: Colors.blueGrey,
        child: GestureDetector(
          onHorizontalDragDown: null,
          child: Stack(
            children: [
              compass(),
            ],
          ),
        ));
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