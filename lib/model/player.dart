import 'package:flutter/material.dart';

class Player {
  final String name;
  final IconData iconData;
  bool isTurn;
  int returnCount = 3;

  Player({
    required this.name,
    required this.isTurn,
    required this.iconData,
  });

  void setTurn() {
    isTurn ? isTurn = false : isTurn = true;
  }

  void decReturnCount() {
    if (returnCount >= 0) returnCount--;
  }

  @override
  String toString() {
    return 'name: $name, isFirst: $isTurn';
  }
}
