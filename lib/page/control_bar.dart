import 'package:flutter/material.dart';
import 'package:paint_board_test/res/theme_data.dart';
import 'package:provider/provider.dart';

import 'drawing_page/local_utils/DrawingProvider.dart';

enum PaintBoardAction {
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
              paintBoardAction: PaintBoardAction.save),
          controlTextButton(
              title: "LOAD",
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.load),
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
              paintBoardAction: PaintBoardAction.addBackGroundImage),
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
              paintBoardAction: PaintBoardAction.backward),
          controlIconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.forward),
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
              paintBoardAction: PaintBoardAction.pen),
          controlTextButton(
              title: "ERASE",
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.erase),
        ],
      ),
    );
  }

  controlTextButton(
      {String title,
      DrawingProvider drawingProvider,
      PaintBoardAction paintBoardAction}) {
    if (title == null) title = "";

    return InkWell(
      onTap: () {
        controlBarFunction(paintBoardAction: paintBoardAction,drawingProvider: drawingProvider);
      },
      child: Container(
        decoration: boxTheme.basicOutlineGreyBox,
        height: 40,
        width: 40,
        child: Center(
          child: Text(
            title,
            style: textTheme.basicTextStyle,
          ),
        ),
      ),
    );
  }

  controlIconButton(
      {Icon icon,
      DrawingProvider drawingProvider,
      PaintBoardAction paintBoardAction}) {
    bool isIcon = true;
    if (icon == null) isIcon = false;

    return InkWell(
      onTap: () {
        controlBarFunction(paintBoardAction: paintBoardAction,drawingProvider: drawingProvider);
      },
      child: Container(
        decoration: boxTheme.basicOutlineGreyBox,
        height: 40,
        width: 40,
        child: Center(
          child: isIcon ? icon : Container(),
        ),
      ),
    );
  }

  controlBarFunction({
    PaintBoardAction paintBoardAction,
    DrawingProvider drawingProvider,
  }) {
    switch (paintBoardAction) {
      case PaintBoardAction.save:
        break;
      case PaintBoardAction.load:
        break;
      case PaintBoardAction.addBackGroundImage:
        break;
      case PaintBoardAction.backward:
        break;
      case PaintBoardAction.forward:
        break;
      case PaintBoardAction.pen:
        drawingProvider.pencilMode();
        break;
      case PaintBoardAction.erase:
        drawingProvider.eraseMode();
        break;
    }
  }
}
