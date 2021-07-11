import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paint_board_test/page/paint_board.dart';
import 'package:video_player/video_player.dart';

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
