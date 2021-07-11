import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paint_board_test/models/DotInfo.dart';
import 'dart:ui' as ui
    show Image, Codec, instantiateImageCodec, decodeImageFromList;
import 'package:image/image.dart' as IMG;

class DrawingProvider extends ChangeNotifier {
  final lines = <List<DotInfo>>[];

  final temp = <List<DotInfo>>[];

  double _size = 3;

  double get size => _size;

  Color _color = Colors.black;

  double _erasSize = 10;

  double get eraseSize => _erasSize;

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
    lines.add(oneLine);
    notifyListeners();
  }

  void drawing(Offset offset) {
    double dx = offset.dx;
    double dy = offset.dy;

    if (dy < 3) {
      dy = 3;
    }

    Offset offSetData = Offset(dx, dy);

    lines.last.add(DotInfo(offSetData, size, color));
    notifyListeners();
  }

  void eraseStart(Offset offset) {
    var oneLine = <DotInfo>[];
    oneLine.add(DotInfo(offset, eraseSize, _eraseColor));
    lines.add(oneLine);
    notifyListeners();
  }

  void erasing(Offset offset) {
    double dx = offset.dx;
    double dy = offset.dy;

    if (dy < 10) {
      dy = 3;
    }

    Offset offSetData = Offset(dx, dy);
    lines.last.add(DotInfo(offSetData, eraseSize, _eraseColor));
    notifyListeners();
  }

  void backward() {
    if (lines.length > 0) {
      temp.add(lines.last);
      lines.removeLast();
      print(lines.length);
      notifyListeners();
    }
  }

  void forward() {
    if (temp.length > 0) {
      lines.add(temp.last);
      temp.removeLast();
      print(temp.length);
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
}
