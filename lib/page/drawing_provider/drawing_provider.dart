import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paint_board_test/models/dot_info.dart';
import 'dart:ui' as ui show Image, decodeImageFromList;
import 'package:image/image.dart' as IMG;
import 'package:shared_preferences/shared_preferences.dart';

class DrawingProvider extends ChangeNotifier {
  var backwardHistory = BoardData(List<Line>());
  var forwardHistory = BoardData(List<Line>());

  double _size = 3;

  double get size => _size;

  Color _color = Colors.black;

  double _eraseSize = 10;

  double get eraseSize => _eraseSize;

  Color _eraseColor = ThemeData().scaffoldBackgroundColor;

  Color get color => _color;

  bool _eraseMode = false;

  bool get getEraseMode => _eraseMode;

  ui.Image _image;

  ui.Image get getImage => _image;

  void eraseMode() {
    _eraseMode = true;
    notifyListeners();
  }

  void pencilMode() {
    _eraseMode = false;
    notifyListeners();
  }

  void drawStart(Offset offset) {
    var oneLine = <DotInfo>[];
    oneLine.add(DotInfo(offset, size, color));
    backwardHistory.lines.add(Line(List<DotInfo>())..line = oneLine);
    notifyListeners();
  }

  void drawing(Offset offset) {
    double dx = offset.dx;
    double dy = offset.dy;

    if (dy < size) {
      dy = _size;
    }

    Offset offSetData = Offset(dx, dy);

    backwardHistory.lines.last.line.add(DotInfo(offSetData, size, color));

    notifyListeners();
  }

  void eraseStart(Offset offset) {
    var oneLine = <DotInfo>[];
    oneLine.add(DotInfo(offset, _eraseSize, _eraseColor));
    backwardHistory.lines.add(Line(List<DotInfo>())..line = oneLine);

    notifyListeners();
  }

  void erasing(Offset offset) {
    double dx = offset.dx;
    double dy = offset.dy;

    if (dy < _eraseSize) {
      dy = _size;
    }

    Offset offSetData = Offset(dx, dy);
    backwardHistory.lines.last.line
        .add(DotInfo(offSetData, _eraseSize, _eraseColor));
    notifyListeners();
  }

  void backward() {
    if (backwardHistory.lines.length > 0) {
      forwardHistory.lines.add(backwardHistory.lines.last);
      backwardHistory.lines.removeLast();
      print("remain backward task");
      print(backwardHistory.lines.length);
      notifyListeners();
    }
  }

  void forward() {
    if (forwardHistory.lines.length > 0) {
      backwardHistory.lines.add(forwardHistory.lines.last);
      forwardHistory.lines.removeLast();
      print("remain forward task");
      print(forwardHistory.lines.length);
      notifyListeners();
    }
  }

  void loadImage(double width, double height, PickedFile imageFile) async {
    Uint8List bd = await imageFile.readAsBytes();

    final Uint8List bytes = Uint8List.view(bd.buffer);

    final IMG.Image image = IMG.decodeImage(bytes);

    final IMG.Image resized =
        IMG.copyResize(image, width: width.toInt(), height: height.toInt());

    final List<int> resizedBytes = IMG.encodePng(resized);

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(
        resizedBytes, (ui.Image img) => completer.complete(img));
    _image = await completer.future;
    notifyListeners();
  }

  void resetBoard() {
    forwardHistory.lines.clear();
    backwardHistory.lines.clear();
    removeBackgroundImage();
    notifyListeners();
  }

  void removeBackgroundImage() {
    _image = null;
    notifyListeners();
  }

  void savePaintBoard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //json to String
    Map<String, dynamic> backWardHistoryMap = backwardHistory.toJson();
    Map<String, dynamic> forwardHistoryMap = forwardHistory.toJson();

    //json to String
    String backwardMapString =
        jsonEncode(BoardData.fromJson(backWardHistoryMap));
    String forwardMapString = jsonEncode(BoardData.fromJson(forwardHistoryMap));

    List<String> index = List<String>();
    List<String> lineListAndHistory = [];

    lineListAndHistory.add(backwardMapString);
    lineListAndHistory.add(forwardMapString);

    index = prefs.getStringList("index");

    if (index == null) {
      index = List<String>();
      index.add("0");
    } else {
      index.add(index.length.toString());
    }

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy_MM_dd_hh_mm_ss').format(now);

    print(formattedDate);
    String boardName = "save_";
    boardName = boardName + formattedDate;

    prefs.setString(index.last, boardName);
    prefs.setStringList(boardName, lineListAndHistory);

    prefs.setStringList("index", index);

    notifyListeners();
  }

  void loadPaintBoard(String boardName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _lineListIndex = 0;
    int _tempIndex = 1;
    List<String> lineListAndHistory = [];
    bool cancelSelect = true;

    if (boardName != null) {
      cancelSelect = false;
    }

    if (!cancelSelect) {
      lineListAndHistory = prefs.getStringList(boardName);

      String lineListMapString = lineListAndHistory[_lineListIndex];
      String tempMapString = lineListAndHistory[_tempIndex];

      Map<String, dynamic> lineListMap = jsonDecode(lineListMapString);
      Map<String, dynamic> tempMap = jsonDecode(tempMapString);

      backwardHistory = BoardData.fromJson(lineListMap);
      forwardHistory = BoardData.fromJson(tempMap);

      removeBackgroundImage();
      notifyListeners();
    }
  }
}
