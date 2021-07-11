import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:paint_board_test/models/DotInfo.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/widgets.dart' hide Image;
import 'package:provider/provider.dart';
import 'drawing_page/local_utils/DrawingProvider.dart';
import 'dart:ui' as ui show Image;

class PaintBoard extends StatefulWidget {
  const PaintBoard({Key key}) : super(key: key);

  @override
  _PaintBoardState createState() => _PaintBoardState();
}

class _PaintBoardState extends State<PaintBoard> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DrawingProvider>(context);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              CustomPaint(
                painter: DrawingImagePainter(myBackground: p.getImage),
              ),
              CustomPaint(
                painter: DrawingPencilPainter(lines: p.lines),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (s) {
                  if (p.getEraseMode) {
                    p.eraseStart(s.localPosition);
                  } else {
                    p.drawStart(s.localPosition);
                  }
                },
                onPanUpdate: (s) {
                  if (s.localPosition.dy > 0) {
                    if (p.getEraseMode) {
                      p.erasing(s.localPosition);
                    } else {
                      p.drawing(s.localPosition);
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

class DrawingImagePainter extends CustomPainter {
  const DrawingImagePainter({this.myBackground,});
  final ui.Image myBackground;

  @override
  void paint(Canvas canvas, Size size) {

    if(myBackground != null){
      canvas.drawImage( myBackground, Offset.zero, Paint());
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
