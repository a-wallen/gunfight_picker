import 'package:flutter/material.dart';

Widget colMaker(String title, String subtitleText){
  return Container(
    child: Column(
      children: [
        Text(title),
        Text(subtitleText),
      ],
    ),
  );
}

Widget rowMaker(String title, String subtitleText){
  return Container(
    child: Column(
      children: [
        Text(title),
        Text(subtitleText),
      ],
    ),
  );
}