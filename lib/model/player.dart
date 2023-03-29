import 'package:flutter/material.dart';

class Player {
  final String name;
  final bool isFirst;
  final IconData iconData;
  int returnCount = 3;

  Player({
    required this.name,
    required this.isFirst,
    required this.iconData,
  });
}
