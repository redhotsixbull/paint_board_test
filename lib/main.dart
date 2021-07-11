import 'package:flutter/material.dart';
import 'package:paint_board_test/page/drawing_page/main_page.dart';
import 'package:provider/provider.dart';
import 'page/drawing_provider/drawing_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DrawingProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => DrawingProvider(), child: MainPage()),
    );
  }
}
