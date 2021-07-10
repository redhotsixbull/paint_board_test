import 'package:flutter/material.dart';
import 'package:paint_board_test/page/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => null,
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
      home:
          ChangeNotifierProvider(create: (context) => null, child: MainPage()),
    );
  }
}
