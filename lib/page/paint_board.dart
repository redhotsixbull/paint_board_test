import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:paint_board_test/models/DotInfo.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/widgets.dart' hide Image;
import 'package:provider/provider.dart';

import 'drawing_page/local_utils/DrawingProvider.dart';

class PaintBoard extends StatefulWidget {
  const PaintBoard({Key key, this.painterController}) : super(key: key);

  final PainterController painterController;

  @override
  _PaintBoardState createState() => _PaintBoardState();
}

class _PaintBoardState extends State<PaintBoard> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DrawingProvider>(context);

    return Stack(
      children: [
        CustomPaint(
          painter: DrawingPencilPainter(lines: p.lines),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (s) {
            if(p.eraseMode){
              p.erase(s.localPosition);
            }else{
              p.drawStart(s.localPosition);
            }
          },
          onPanUpdate: (s) {
            if(p.eraseMode){
              p.erase(s.localPosition);
            }else{
              p.drawing(s.localPosition);
            }
          },
          child: Container(),
        ),
      ],
    );
  }
}

class DrawingPencilPainter extends CustomPainter {
  const DrawingPencilPainter({@required this.lines}) : assert(lines != null);
  final List<List<DotInfo>> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (var oneLine in lines) {
      Color color;
      double size;
      var l = <Offset>[];
      var p = Path();
      for (var oneDot in oneLine) {
        color ??= oneDot.color;
        size ??= oneDot.size;
        l.add(oneDot.offset);
      }
      p.addPolygon(l, false);
      canvas.drawPath(
          p,
          Paint()
            ..color = color
            ..strokeWidth = size
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PainterController extends ChangeNotifier {
  Color _drawColor = Colors.black;
  bool _eraseMode = false;

  double _thickness = 1.0;
  _PathHistory _pathHistory;

  PainterController() : _pathHistory = new _PathHistory();

  bool get isEmpty => _pathHistory.isEmpty;

  bool get eraseMode => _eraseMode;

  set eraseMode(bool enabled) {
    _eraseMode = enabled;
    _updatePaint();
  }

  Color get drawColor => _drawColor;

  void _updatePaint() {
    Paint paint = new Paint();
    if (_eraseMode) {
      paint.blendMode = BlendMode.clear;
      paint.color = Color.fromARGB(0, 255, 0, 0);
    } else {
      paint.color = drawColor;
      paint.blendMode = BlendMode.srcOver;
    }
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = _thickness;

    _pathHistory.currentPaint = paint;
    notifyListeners();
  }

  void undo() {
    _pathHistory.undo();
    notifyListeners();
  }
}

class _PathHistory {
  List<MapEntry<Path, Paint>> _paths;
  Paint currentPaint;
  Paint _backgroundPaint;
  bool _inDrag;

  bool get isEmpty => _paths.isEmpty || (_paths.length == 1 && _inDrag);

  _PathHistory()
      : _paths = <MapEntry<Path, Paint>>[],
        _inDrag = false,
        _backgroundPaint = new Paint()..blendMode = BlendMode.dstOver,
        currentPaint = new Paint()
          ..color = Colors.black
          ..strokeWidth = 1.0
          ..style = PaintingStyle.fill;

  void setBackgroundColor(Color backgroundColor) {
    _backgroundPaint.color = backgroundColor;
  }

  void undo() {
    if (!_inDrag) {
      _paths.removeLast();
    }
  }

  void clear() {
    if (!_inDrag) {
      _paths.clear();
    }
  }

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = new Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _paths.add(new MapEntry<Path, Paint>(path, currentPaint));
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      Path path = _paths.last.key;
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void endCurrent() {
    _inDrag = false;
  }

  void draw(Canvas canvas, Size size) {
    canvas.saveLayer(Offset.zero & size, Paint());
    for (MapEntry<Path, Paint> path in _paths) {
      Paint p = path.value;
      canvas.drawPath(path.key, p);
    }
    canvas.drawRect(
        new Rect.fromLTWH(0.0, 0.0, size.width, size.height), _backgroundPaint);
    canvas.restore();
  }
}
