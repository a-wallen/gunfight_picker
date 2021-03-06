import "dart:math";

import 'package:flutter/material.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:gunfight_picker/data/codeToGameMode.dart';
import 'package:gunfight_picker/data/codeToImage.dart';
import 'package:gunfight_picker/data/codeToName.dart';
import 'package:gunfight_picker/functions/fetchMaps.dart';
import 'package:shake/shake.dart';
import 'package:gunfight_picker/theme/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MapPickerPage extends StatefulWidget {
  @override
  _MapPickerPageState createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  String gamemode = "cyber"; // gunfight
  String gameMap = "mp_cave_am";
  ShakeDetector detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      _pickMap(gamemode);
    });
    print("Shake initialized");
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  void _pickMap(String gamemode) async {
    //emphasis on error checking
    assert(gamemode.isNotEmpty);
    if (jsonResponse == null) await fetchMaps();

    final Random rng = Random();
    List _possibleMaps = [];
    // bad comment
    jsonResponse.forEach((key, value) {
      if (value.contains(gamemode)) {
        _possibleMaps.add(key);
      }
    });

    setState(() {
      gameMap = _possibleMaps[rng.nextInt(_possibleMaps.length - 1)];
    });
    print(gameMap);
    print(gamemode);
  }

  setGameMode(String gm) {
    setState(() {
      this.gamemode = gm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MapPicker(this),
        Text(
          "Selected: ${codeToGameMode[gamemode]}",
          style: TextStyle(color: davys_grey, fontSize: 12.0),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: GameModeSearch(this),
        ),
      ],
    );
  }
}

class MapPicker extends StatefulWidget {
  _MapPickerPageState parent;
  MapPicker(_MapPickerPageState mpps) {
    this.parent = mpps;
  }
  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  Future<Map> apiResponse;
  bool isExpanded = true;

  @override
  void initState() {
    apiResponse = getJSON();
    super.initState();
  }

  Future<Map> getJSON() async {
    await fetchMaps();
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: apiResponse,
          builder: (context, projectSnap) {
            if (projectSnap.hasData == null) {
              return Container(height: 0.0, width: 0.0);
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                            widget.parent.setState(() {
                              widget.parent._pickMap(widget.parent.gamemode);
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 1000),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(isExpanded ? 32 : 4),
                                ),
                              ),
                              height: isExpanded ? 180 : 100,
                              width: isExpanded ? 320 : 240,
                              curve: Curves.bounceOut,
                              child: codeToMapImage[widget.parent.gameMap],
                            ),
                          ),
                        ),
                        Text(
                          codeToMap[widget.parent.gameMap],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

class GameModeSearch extends StatefulWidget {
  _MapPickerPageState parent;
  GameModeSearch(_MapPickerPageState mps) {
    this.parent = mps;
  }
  @override
  _GameModeSearchState createState() => _GameModeSearchState();
}

class _GameModeSearchState extends State<GameModeSearch> {
  TextEditingController _textController = TextEditingController();
  Future<List<String>> mainDataList;
  Future<List<String>> newDataList;
  String selectedGM;

  void initState() {
    this.mainDataList = this.getGameModes();
    this.newDataList = this.mainDataList;
    super.initState();
  }

  Future<List<String>> getGameModes() async {
    List<String> temp = new List();
    await fetchMaps();
    jsonResponse.forEach((key, value) {
      for (var gm in value) {
        if (!temp.contains(gm)) temp.add(gm);
      }
    });

    return temp;
  }

  onItemChanged(String searchVal) {
    setState(() {
      newDataList = mainDataList.then((value) {
        return value
            .where((string) => codeToGameMode[string]
                .toLowerCase()
                .contains(searchVal.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Theme(
            child: TextField(
              autofocus: true,
              controller: _textController,
              cursorColor: dark_vanilla,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: dark_vanilla, width: 3.0),
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for a game mode',
              ),
              onChanged: onItemChanged,
            ),
            data: Theme.of(context).copyWith(primaryColor: dark_vanilla),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: newDataList,
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              //List<Widget> children;
              if (snapshot.hasData) {
                return (ListView.builder(
                  padding: EdgeInsets.all(12.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, position) {
                    String element = snapshot.data[position];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      margin: EdgeInsets.all(5.0),
                      color: selectedGM == snapshot.data[position]
                          ? dark_vanilla
                          : lotion,
                      elevation: 10.0,
                      child: ListTile(
                        title: Text(
                          codeToGameMode[element],
                          style: TextStyle(
                              color: selectedGM == snapshot.data[position]
                                  ? jacko_bean
                                  : davys_grey),
                        ),
                        trailing: Icon(Icons.check,
                            color: selectedGM == snapshot.data[position]
                                ? jacko_bean
                                : Colors.grey),
                        onTap: () {
                          setState(() {
                            selectedGM = snapshot.data[position];
                          });
                          widget.parent.setGameMode(snapshot.data[position]);
                          print(widget.parent.gamemode);
                        },
                      ),
                    );
                  },
                ));
              }
              return Container(
                child: CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 10.0,
                    animation: true,
                    percent: 1,
                    header: Text("Loading Maps"),
                    center: Icon(Icons.location_searching, //_outlined,
                        size: 50.0,
                        color: dark_vanilla),
                    backgroundColor: davys_grey,
                    progressColor: dark_vanilla),
              );
            },
          ),
        ),
      ],
    );
  }
}
