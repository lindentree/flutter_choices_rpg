import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'stats.dart';
import 'player_state.dart';

import 'package:flutter/services.dart';

class ChapterView extends StatefulWidget {
  @override
  _ChapterViewState createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  var _pages = {};
  var _pageChoices = [];
  Map _playerValues;
  String _pageNumber = "1";

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('stories/sample_story.json');
    final data = await json.decode(response);
    setState(() {
      _pages = data;
      _pageChoices = _pages[_pageNumber]["choices"];
      print(_pages);
    });
  }

  void reset() {
    setState(() {
      _playerValues = {"health": 9, "cash": 20};
    });
  }

  @override
  void initState() {
    readJson();

    super.initState();
    _playerValues = {"health": 9, "cash": 20};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: new Color.fromRGBO(255, 255, 255, 0.5),
          border: new Border.all(
              color: Colors
                  .transparent), //color is transparent so that it does not blend with the actual color specified
          //borderRadius: const BorderRadius.all(const Radius.circular(30.0),
          // Specifies the background color and the opacity
        ),
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                child: Stats(
                  stats: _playerValues,
                  child: PlayerState(),
                ),
              ),
              (_pages != null &&
                      _pages[_pageNumber] != null &&
                      _pages[_pageNumber]["titleImage"] != "")
                  ? Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Image.asset(
                        _pages[_pageNumber]["titleImage"],
                        height: 250.0,
                        fit: BoxFit.cover,
                      ))
                  : SizedBox(),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    _pages[_pageNumber] != null
                        ? _pages[_pageNumber]["pageText"]
                        : "",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: new ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                          height: 20.0,
                        ),
                    itemCount: _pageChoices.length,
                    itemBuilder: (BuildContext cxt, int index) {
                      return TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.yellow),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.yellow)))),
                        onPressed: () {
                          setState(() {
                                                        print(_pageChoices);

                            if (_pageChoices[index]["results"].length > 0) {
                              _playerValues = {
                                "health": _pageChoices[index]["results"][0],
                                "cash": 20
                              };
                            }

                            _pageNumber =
                                _pageChoices[index]["link"].toString();

                            _pageChoices = _pages[_pageNumber]["choices"];

                            if (_pageNumber == "1") {
                              reset();
                            }
                          });
                        },
                        child: Text(
                          _pageChoices[index]["choiceText"] ?? "",
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
