import 'package:flelvin/debouncer.dart';
import 'package:flutter/material.dart';

class StatefulSlider extends StatefulWidget {
  StatefulSlider({this.roomId, this.value, this.applyUpdate});

  final String roomId;
  final double value;
  final Function applyUpdate;

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<StatefulSlider> {
  String _roomId;
  double _value;
  Function _applyUpdate;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    setState(() {
      _roomId = widget.roomId;
      _value = widget.value;
      _applyUpdate = widget.applyUpdate;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
        value: _value,
        min: 0.0,
        max: 255.0,
        onChanged: (value) {
          _debouncer.run(() {
            _applyUpdate(_roomId, true, value.toInt());
          });
          setState(() {
            _value = value;
          });
        });
  }
}
