import 'package:flutter/material.dart';
import 'package:gunfight_picker/theme/theme.dart';

Widget compassView(BuildContext context) {
  double length = MediaQuery.of(context).size.width;

  void aarowNaviateOnPressed(int direction) {}

  return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: length / 5,
      color: Colors.blueGrey,
      child: GestureDetector(
        onHorizontalDragDown: null,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: null,
            ),
            compass(),
            IconButton(icon: Icon(Icons.arrow_right), onPressed: null),
          ],
        ),
      ));
}

Widget compass() {
  return Container();
}
