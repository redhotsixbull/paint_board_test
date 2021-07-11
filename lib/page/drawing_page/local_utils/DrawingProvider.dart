import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paint_board_test/models/DotInfo.dart';
import 'dart:ui' as ui show Image, decodeImageFromList, PictureRecorder;
import 'package:image/image.dart' as IMG;

class DrawingProvider extends ChangeNotifier {
  final lineList = LineList(List<Line>());

  final temp =  LineList(List<Line>());

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

  bool _isSetImage = false;

  bool get getIsSetImage => _isSetImage;

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
    lineList.lines.add(Line(List<DotInfo>())..line = oneLine);
    notifyListeners();
  }

  void drawing(Offset offset) {
    double dx = offset.dx;
    double dy = offset.dy;

    if (dy < 3) {
      dy = 3;
    }

    Offset offSetData = Offset(dx, dy);

    lineList.lines.last.line.add(DotInfo(offSetData, size, color));

    notifyListeners();
  }

  void eraseStart(Offset offset) {
    var oneLine = <DotInfo>[];
    oneLine.add(DotInfo(offset, _eraseSize, _eraseColor));
    lineList.lines.add(Line(List<DotInfo>())..line = oneLine);

    notifyListeners();
  }

  void erasing(Offset offset) {
    double dx = offset.dx;
    double dy = offset.dy;

    if (dy < 10) {
      dy = 3;
    }

    Offset offSetData = Offset(dx, dy);
    lineList.lines.last.line.add(DotInfo(offSetData, _eraseSize, _eraseColor));
    notifyListeners();
  }

  void backward() {
    if (lineList.lines.length > 0) {
      temp.lines.add(lineList.lines.last);
      lineList.lines.removeLast();
      print("remain backward task");
      print(lineList.lines.length);
      notifyListeners();
    }
  }

  void forward() {
    if (temp.lines.length > 0) {
      lineList.lines.add(temp.lines.last);
      temp.lines.removeLast();
      print("remain forward task");
      print(temp.lines.length);
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

    setImage();
  }

  void setImage() {
    _isSetImage = true;
    notifyListeners();
  }

  void removeBackground() {
    _isSetImage = false;
    notifyListeners();
  }

  void clearImage() {
      temp.lines.clear();
      lineList.lines.clear();
      _image = null;
      notifyListeners();
  }

  void savePaintBoard() async {



    print(lineList.toString());
    print(temp.toString());

  }
}
