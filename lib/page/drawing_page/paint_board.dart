import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:paint_board_test/models/dot_info.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/widgets.dart' hide Image;
import 'package:provider/provider.dart';
import '../drawing_provider/drawing_provider.dart';
import 'dart:ui' as ui show Image;

class PaintBoard extends StatefulWidget {
  const PaintBoard({Key key}) : super(key: key);

  @override
  _PaintBoardState createState() => _PaintBoardState();
}

class _PaintBoardState extends State<PaintBoard> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DrawingProvider>(context);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              CustomPaint(
                painter: DrawingImagePainter(myBackground: provider.getImage),
              ),
              CustomPaint(
                painter:
                    DrawingPencilPainter(lineList: provider.backwardHistory),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (s) {
                  if (provider.getEraseMode) {
                    provider.eraseStart(s.localPosition);
                  } else {
                    provider.drawStart(s.localPosition);
                  }
                },
                onPanUpdate: (s) {
                  if (s.localPosition.dy > 0) {
                    if (provider.getEraseMode) {
                      provider.erasing(s.localPosition);
                    } else {
                      provider.drawing(s.localPosition);
                    }
                  }
                },
                child: Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DrawingPencilPainter extends CustomPainter {
  const DrawingPencilPainter({@required this.lineList})
      : assert(lineList != null);
  final BoardData lineList;

  @override
  void paint(Canvas canvas, Size size) {
    for (var oneLine in lineList.lines) {
      Color color;
      double size;
      var l = <Offset>[];
      var path = Path();
      for (var oneDot in oneLine.line) {
        color ??= oneDot.color;
        size ??= oneDot.size;
        l.add(oneDot.offset);
      }
      path.addPolygon(l, false);

      canvas.drawPath(
          path,
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

class DrawingImagePainter extends CustomPainter {
  const DrawingImagePainter({
    this.myBackground,
  });

  final ui.Image myBackground;

  @override
  void paint(Canvas canvas, Size size) {
    if (myBackground != null) {
      canvas.drawImage(myBackground, Offset.zero, Paint());
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
