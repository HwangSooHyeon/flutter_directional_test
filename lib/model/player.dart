import 'package:flutter/material.dart';

class Player {
  final String name;
  final bool isTurn;
  final IconData iconData;
  int returnCount = 3;

  Player({
    required this.name,
    required this.isTurn,
    required this.iconData,
  });

  @override
  String toString() {
    return 'name: $name, isFirst: $isTurn';
  }
}
