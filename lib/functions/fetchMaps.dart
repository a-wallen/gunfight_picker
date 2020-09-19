import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:gunfight_picker/main.dart';
import 'package:gunfight_picker/pages/HomePage.dart';
import 'package:gunfight_picker/functions/makeMapList.dart';

fetchMaps() async {
  String apiUrl =
      "https://my.callofduty.com/api/papi-client/ce/v1/title/mw/platform/battle/gameType/mp/communityMapData/availability";
  var response = await http.get(apiUrl);
  if (response.statusCode == 200) {
    jsonResponse = convert.jsonDecode(response.body);
    jsonResponse = jsonResponse["data"];
    print(jsonResponse);
    mapList = makeMapList(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}