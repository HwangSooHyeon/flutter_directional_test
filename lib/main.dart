import 'package:flutter/material.dart';
import 'package:flutter_directional_test/screen/home_screen.dart';

import 'model/game_board.dart';

void main() {
  final List<GameBoard> saves = [];

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        saves: saves,
      ),
    ),
  );
}
