import 'package:flutter/material.dart';
import 'package:flutter_directional_test/model/game_board.dart';
import 'package:flutter_directional_test/model/player.dart';

class GameScreen extends StatefulWidget {
  final GameBoard gameBoard;
  final Player player1;
  final Player player2;

  const GameScreen({
    Key? key,
    required this.gameBoard,
    required this.player1,
    required this.player2,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
