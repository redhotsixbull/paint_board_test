import 'package:flutter/material.dart';
import 'package:paint_board_test/page/paint_board.dart';

import 'control_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ControlBar(),
            ),
            Expanded(child: PaintBoard()),
          ],
        ),
      ),
    );
  }
}
