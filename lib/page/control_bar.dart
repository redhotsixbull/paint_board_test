import 'package:flutter/material.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({Key key}) : super(key: key);

  @override
  _ControlBarState createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.grey[300],
    );
  }
}
