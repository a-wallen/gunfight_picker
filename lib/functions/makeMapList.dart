import 'package:gunfight_picker/pages/HomePage.dart';
import 'package:gunfight_picker/data/codeToName.dart';

List makeMapList(Map data) {
  data.forEach((key, value) {
    mapList.add(codeToMapName(key));
  });
  print(mapList);
}