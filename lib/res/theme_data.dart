import 'package:flutter/material.dart';

class BoxTheme {
  final BoxDecoration basicOutlineGreyBox = BoxDecoration(
      color: Colors.grey[400],
      borderRadius: BorderRadius.circular(16));
}

class TextTheme {
  final TextStyle basicTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal
  );
}

final boxTheme = BoxTheme();
final textTheme = TextTheme();
