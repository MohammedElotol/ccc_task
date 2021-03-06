import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final workItem;
  final Function onProgressUpdated;

  SliderWidget(this.workItem, this.onProgressUpdated(value));

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: widget.workItem.progress.toDouble(),
      min: 0,
      max: 100,
      divisions: 10,
      label: widget.workItem.progress.round().toString(),
      onChanged: (double value) {
        setState(() {
          widget.workItem.progress = value.toInt();
          widget.onProgressUpdated(widget.workItem.progress);
        });
      },
    );
  }
}
