// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '../actions/index.dart'; // Imports custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom widget code
class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({
    Key key,
    this.width,
    this.height,
    this.minRange,
    this.maxRange,
  }) : super(key: key);

  final double width;
  final double height;
  final int minRange;
  final int maxRange;

  @override
  _CustomRangeSliderState createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  RangeValues currentRangeValues;
  void initState() {
    currentRangeValues =
        RangeValues(widget.minRange ?? 0, widget.maxRange ?? 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 2.0,
          thumbColor: Colors.white,
          overlappingShapeStrokeColor: Colors.blue,
        ),
        child: RangeSlider(
            values: currentRangeValues,
            max: widget.maxRange.toDouble(),
            min: widget.minRange.toDouble(),
            divisions: 0,
            inactiveColor: Color(0xffa5a5a5).withOpacity(0.3),
            onChanged: (RangeValues values) {
              setState(() {
                currentRangeValues = values;
              });
            }),
      ),
    );
  }
}
