import 'package:flutter/material.dart';

class BoardData {
  List<Line> lines;
  List<String> imageFilePath; //TODO 이미지 파일 경로 까지 되돌리기를 구현하려면 사용

  BoardData(this.lines);

  BoardData.fromJson(Map<String, dynamic> json) {
    if (json['lines'] != null) {
      lines = new List<Line>();
      json['lines'].forEach((v) {
        lines.add(new Line.fromJson(v));
      });
    }

    if (json['imageFilePath'] != null) {
      imageFilePath = new List<String>();
      json['imageFilePath'].forEach((v) {
        imageFilePath.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lines != null) {
      data['lines'] = this.lines.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Line {
  List<DotInfo> line;

  Line(this.line);

  Line.fromJson(Map<String, dynamic> json) {
    if (json['line'] != null) {
      line = new List<DotInfo>();
      json['line'].forEach((v) {
        line.add(new DotInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.line != null) {
      data['line'] = this.line.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DotInfo {
  DotInfo(this.offset, this.size, this.color);

  Offset offset;
  double size;
  Color color;

  DotInfo.fromJson(Map<String, dynamic> json) {
    double dx = json['dx'];
    double dy = json['dy'];

    offset = Offset(dx, dy);
    size = json['size'];
    color =
        Color.fromRGBO(json['red'], json['red'], json['red'], json['opacity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dx'] = this.offset.dx.toDouble();
    data['dy'] = this.offset.dy.toDouble();
    data['size'] = this.size.toDouble();
    data['red'] = this.color.red;
    data['green'] = this.color.green;
    data['blue'] = this.color.blue;
    data['opacity'] = this.color.opacity;
    return data;
  }
}
