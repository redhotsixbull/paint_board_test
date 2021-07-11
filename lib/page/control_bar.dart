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

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.grey[300],
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: _saveAndLoadButtonGroup(
              p,
              width,
              height,
            ),
          ),
          Expanded(
            flex: 1,
            child: _setBackGroundImageButton(
              p,
              width,
              height,
            ),
          ),
          Expanded(
            flex: 1,
            child: _backwardAndForward(
              p,
              width,
              height,
            ),
          ),
          Expanded(
            flex: 1,
            child: _penAndEraser(
              p,
              width,
              height,
            ),
          )
        ],
      ),
    );
  }

  _saveAndLoadButtonGroup(
    DrawingProvider p,
    double width,
    double height,
  ) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(width, height,
              title: "SAVE",
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.save),
          controlTextButton(width, height,
              title: "LOAD",
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.load),
        ],
      ),
    );
  }

  _setBackGroundImageButton(
    DrawingProvider p,
    double width,
    double height,
  ) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(width, height,
              title: "ADD",
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.addBackGroundImage),
        ],
      ),
    );
  }

  _backwardAndForward(
    DrawingProvider p,
    double width,
    double height,
  ) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlIconButton(width, height,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.backward),
          controlIconButton(width, height,
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

  _penAndEraser(DrawingProvider p, double width, double height) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controlTextButton(width, height,
              title: "PEN",
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.pen),
          controlTextButton(width, height,
              title: "ERASE",
              drawingProvider: p,
              paintBoardAction: PaintBoardAction.erase),
        ],
      ),
    );
  }

  controlTextButton(double width, double height,
      {String title,
      DrawingProvider drawingProvider,
      PaintBoardAction paintBoardAction}) {
    if (title == null) title = "";

    return InkWell(
      onTap: () {
        controlBarFunction(width, height,
            paintBoardAction: paintBoardAction,
            drawingProvider: drawingProvider);
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

  controlIconButton(double width, double height,
      {Icon icon,
      DrawingProvider drawingProvider,
      PaintBoardAction paintBoardAction}) {
    bool isIcon = true;
    if (icon == null) isIcon = false;

    return InkWell(
      onTap: () {
        controlBarFunction(width, height,
            paintBoardAction: paintBoardAction,
            drawingProvider: drawingProvider);
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

  controlBarFunction(
    double width,
    double height, {
    PaintBoardAction paintBoardAction,
    DrawingProvider drawingProvider,
  }) {
    switch (paintBoardAction) {
      case PaintBoardAction.save:
        break;
      case PaintBoardAction.load:
        break;
      case PaintBoardAction.addBackGroundImage:
        print("set background Image");
        drawingProvider.loadImage(width, height);
        break;
      case PaintBoardAction.backward:
        print("back ward button");
        drawingProvider.backward();
        break;
      case PaintBoardAction.forward:
        print("forward button");
        drawingProvider.forward();
        break;
      case PaintBoardAction.pen:
        drawingProvider.pencilMode();
        print("pencil mode");
        break;
      case PaintBoardAction.erase:
        drawingProvider.eraseMode();
        print("erase mode");
        break;
    }
  }
}
