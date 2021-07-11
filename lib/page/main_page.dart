import 'package:flutter/material.dart';
import 'package:paint_board_test/page/paint_board.dart';
import 'package:provider/provider.dart';
import 'control_bar.dart';
import 'drawing_page/local_utils/DrawingProvider.dart';

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
          child: Icon(Icons.clear),
          onPressed: (){
            p.clearImage();
          },
        ),
      ),
    );
  }
}
