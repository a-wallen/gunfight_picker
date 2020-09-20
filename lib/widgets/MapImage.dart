import 'package:flutter/material.dart';
import 'package:gunfight_picker/data/codeToImage.dart';

import 'package:gunfight_picker/theme/theme.dart';

Widget mapImage(String mapcode) {
  return Container(
    margin: EdgeInsets.all(5.0),
    color: middle_green,
    child: 
      Image.network(
      "https://www.gamesatlas.com/images/cod-modern-warfare/maps/resized/Azhir-Cave-Night_320x180.jpg"),
    
  );
}
