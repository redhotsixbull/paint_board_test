import 'package:flutter/material.dart';

class LineList {
  List<Line> lines;
  LineList(this.lines);

  LineList.fromJson(Map<String, dynamic> json) {
    if (json['lines'] != null) {
      lines = new List<Line>();
      json['lines'].forEach((v) {
        lines.add(new Line.fromJson(v));
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

    offset = Offset(dx,dy);
    size = json['size'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dx'] = this.offset.dx.toDouble();
    data['dy'] = this.offset.dy.toDouble();
    data['size'] = this.size.toDouble();
    data['color'] = this.color.toString();
    return data;
  }
}
