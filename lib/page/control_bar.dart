import 'package:flutter/material.dart';
import 'package:paint_board_test/res/theme_data.dart';
import 'package:provider/provider.dart';

import 'drawing_page/local_utils/DrawingProvider.dart';

enum ControlBarFunction {
  save,
  load,
  addBackGroundImage,
  backward,
  forward,
  pen,
  erase
}

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
          controlTextButton(
              title: "SAVE",
              drawingProvider: p,
              controlBarFunction: ControlBarFunction.save),
          controlTextButton(
              title: "LOAD",
              drawingProvider: p,
              controlBarFunction: ControlBarFunction.load),
        ],
      ),
    );
  }

  _setBackGroundImageButton(DrawingProvider p) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(
              title: "ADD",
              drawingProvider: p,
              controlBarFunction: ControlBarFunction.addBackGroundImage),
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
              ),
              drawingProvider: p,
              controlBarFunction: ControlBarFunction.backward),
          controlIconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              drawingProvider: p,
              controlBarFunction: ControlBarFunction.forward),
        ],
      ),
    );
  }

  _penAndEraser(DrawingProvider p) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(
              title: "PEN",
              drawingProvider: p,
              controlBarFunction: ControlBarFunction.pen),
          controlTextButton(
              title: "ERASE",
              drawingProvider: p,
              controlBarFunction: ControlBarFunction.erase),
        ],
      ),
    );
  }

  controlTextButton(
      {String title,
      DrawingProvider drawingProvider,
      ControlBarFunction controlBarFunction}) {
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

  controlIconButton(
      {Icon icon,
      DrawingProvider drawingProvider,
      ControlBarFunction controlBarFunction}) {
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

  controlBarFunction({
    ControlBarFunction controlBarFunction,
    DrawingProvider drawingProvider,
  }) {
    switch (controlBarFunction) {
      case ControlBarFunction.save:

        break;
      case ControlBarFunction.load:
        break;
      case ControlBarFunction.addBackGroundImage:
        break;
      case ControlBarFunction.backward:
        break;
      case ControlBarFunction.forward:
        break;
      case ControlBarFunction.pen:
        drawingProvider.pencilMode();
        break;
      case ControlBarFunction.erase:
        drawingProvider.eraseMode();
        break;
    }
  }
}
