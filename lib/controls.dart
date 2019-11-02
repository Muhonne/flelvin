import 'package:flelvin/site.dart';
import 'package:flelvin/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Controls extends StatefulWidget {
  Controls({@required this.api});

  final Api api;

  @override
  _ControlsState createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  Site _site = Site.fromData("", [], []);
  Map<String, double> roomBrightnesses;

  @override
  void initState() {
    widget.api.fetchSite().then((site) => {
          setState(() {
            _site = site;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_site.name),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var room in _site.rooms)
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                room.name,
                                overflow: TextOverflow.ellipsis,
                              )),
                          Expanded(
                            flex: 2,
                            child: Slider(
                              value: _site.getRoomBrightness(room.id),
                              max: 255.0,
                              min: 0.0,
                              onChangeEnd: (value) {
                                //widget.api
                                  //  .applyRoom(room.id, true, value.toInt());
                              },
                              onChanged: (value) {
                                setState(() {
                                  // _sliderValue = value;
                                });
                              },
                            ),
                          )
                        ],
                      )),
                RaisedButton(
                  onPressed: () {
                    widget.api.allOff();
                  },
                  child: Text("All off"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
