import 'package:flutter/material.dart';
import 'package:flutter_directional_test/const/const.dart';

class Player {
  final String name;
  final IconData iconData;
  bool isTurn;
  int returnCount = initialReturnCount;

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
