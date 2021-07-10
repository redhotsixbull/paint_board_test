import 'package:flutter/material.dart';
import 'package:paint_board_test/res/theme_data.dart';

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
      child: Row(
        children: [
       
        ],
      ),
    );
  }

  controlButton({String title}){
    if(title==null) title = "";
    return Container(
      decoration: boxTheme.basicOutlineGreyBox,
      height: 60,
      width: 60,
      child: Center(
        child: Text(
          title
        ),
      ),
    );
  }
}


