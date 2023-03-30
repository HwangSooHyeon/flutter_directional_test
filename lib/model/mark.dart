import 'package:flutter/material.dart';

class Mark {
  final String playerName;
  final IconData iconData;
  final int turn;
  final int index;

  Mark({
    required this.playerName,
    required this.iconData,
    required this.turn,
    required this.index,
  });
}
