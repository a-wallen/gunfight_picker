import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:gunfight_picker/data/codeToName.dart';

Map jsonResponse;
List gameModeList = [];

Future fetchMaps() async {
  String apiUrl =
      "https://my.callofduty.com/api/papi-client/ce/v1/title/mw/platform/battle/gameType/mp/communityMapData/availability";
  var response = await http.get(apiUrl);
  if (response.statusCode == 200) {
    jsonResponse = convert.jsonDecode(response.body);
    jsonResponse = jsonResponse["data"];
    makeGameModeList();
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

void makeGameModeList() {
  jsonResponse.forEach((key, value) {
    if(!gameModeList.contains(value))
      gameModeList.add(codeToMap[value]);
  });
}
