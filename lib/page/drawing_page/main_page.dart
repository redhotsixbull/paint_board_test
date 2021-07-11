import 'package:flutter/material.dart';
import 'package:paint_board_test/page/drawing_page/paint_board.dart';
import 'package:provider/provider.dart';
import 'control_bar.dart';
import '../drawing_provider/drawing_provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<DrawingProvider>(context);

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
        floatingActionButton: FloatingActionButton(
          tooltip: "초기화 버튼",
          child: Icon(Icons.clear),
          onPressed: () {
            p.resetBoard();
          },
        ),
      ),
    );
  }
}
