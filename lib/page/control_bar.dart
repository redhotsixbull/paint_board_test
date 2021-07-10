import 'package:flutter/material.dart';
import 'package:paint_board_test/res/theme_data.dart';
import 'package:provider/provider.dart';

import 'drawing_page/local_utils/DrawingProvider.dart';

class ControlBar extends StatefulWidget {
  const ControlBar({Key key}) : super(key: key);

  @override
  _ControlBarState createState() => _ControlBarState();
}

class _ControlBarState extends State<ControlBar> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DrawingProvider>(context);

    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.grey[300],
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _saveAndLoadButtonGroup(p),
          ),
          Expanded(
            flex: 1,
            child: _setBackGroundImageButton(p),
          ),
          Expanded(
            flex: 1,
            child: _backwardAndForward(p),
          ),
          Expanded(
            flex: 1,
            child: _penAndEraser(p),
          )
        ],
      ),
    );
  }

  _saveAndLoadButtonGroup(DrawingProvider p) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(title: "SAVE"),
          controlTextButton(title: "LOAD"),
        ],
      ),
    );
  }

  _setBackGroundImageButton(DrawingProvider p) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(title: "ADD"),
        ],
      ),
    );
  }

  _backwardAndForward(DrawingProvider p) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlIconButton(
              icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
          controlIconButton(
              icon: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          )),
        ],
      ),
    );
  }

  _penAndEraser(DrawingProvider p) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(title: "PEN"),
          controlTextButton(title: "ERASE"),
        ],
      ),
    );
  }

  controlTextButton({String title}) {
    if (title == null) title = "";

    return Container(
      decoration: boxTheme.basicOutlineGreyBox,
      height: 40,
      width: 40,
      child: Center(
        child: Text(
          title,
          style: textTheme.basicTextStyle,
        ),
      ),
    );
  }

  controlIconButton({Icon icon}) {
    bool isIcon = true;
    if (icon == null) isIcon = false;

    return Container(
      decoration: boxTheme.basicOutlineGreyBox,
      height: 40,
      width: 40,
      child: Center(
        child: isIcon ? icon : Container(),
      ),
    );
  }
}
