import 'package:flutter/material.dart';
import 'package:gunfight_picker/data/codeToImage.dart';

import 'package:gunfight_picker/data/codeToName.dart';
import 'package:gunfight_picker/theme/theme.dart';

Widget mapImage(String mapcode) {
  return Container(
    margin: EdgeInsets.all(5.0),
    color: middle_green,
    child: Image(
      image: codeToMapImage[mapcode],
    ),
  );
}