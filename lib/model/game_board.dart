import 'package:flutter_directional_test/const/const.dart';

import 'mark.dart';

class GameBoard {
  final int size;
  final int winningCondition;
  late List<List<Mark?>> progress;
  List<Mark> history = <Mark>[];
  String winner = '';
  DateTime endTime = DateTime.now();

  GameBoard({
    required this.size,
    required this.winningCondition,
  }) {
    progress = List.generate(
      size,
      (index) => List.filled(size, null, growable: false),
      growable: false,
    );
  }

  void setWinner(String name) {
    winner = name;
  }

  void setEndTime() {
    endTime = DateTime.now();
  }

  void addProgress(Mark mark, int index) {
    int col = index ~/ size;
    int row = index % size;
    progress[col][row] = mark;
  }

  void addHistory(Mark mark) {
    history.add(mark);
  }

  void doReturn() {
    for (int i = 0; i < 2; i++) {
      Mark lastMark = history.last;
      history.removeLast();
      int col = lastMark.index ~/ size;
      int row = lastMark.index % size;
      progress[col][row] = null;
    }
  }

  String checkEnd() {
    int col = history.last.index ~/ size;
    int row = history.last.index % size;
    String playerName = history.last.playerName;
    if (_checkHorizontal(col, row, playerName) == winningCondition ||
        _checkVertical(col, row, playerName) == winningCondition ||
        _checkUpDiagonal(col, row, playerName) == winningCondition ||
        _checkBottomDiagonal(col, row, playerName) == winningCondition) {
      return playerName;
    }
    if (history.length == size * size) {
      return draw;
    }
    return proceed;
  }

  int _checkHorizontal(int col, int row, String playerName) {
    int count = 0;
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        row > 0) {
      row--;
    }
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        row < size) {
      count++;
      row++;
      if (row == size) {
        break;
      }
    }
    return count;
  }

  int _checkVertical(int col, int row, String playerName) {
    int count = 0;
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        col > 0) {
      col--;
    }
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        col < size) {
      count++;
      col++;
      if (col == size) {
        break;
      }
    }
    return count;
  }

  int _checkUpDiagonal(int col, int row, String playerName) {
    int count = 0;
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        col > 0 &&
        row > 0) {
      col--;
      row--;
    }
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        col < size &&
        row < size) {
      count++;
      col++;
      row++;
      if (col == size || row == size) {
        break;
      }
    }
    return count;
  }

  int _checkBottomDiagonal(int col, int row, String playerName) {
    int count = 0;
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        col < size - 1 &&
        row > 0) {
      col++;
      row--;
      if (col == size - 1 || row == 0) {
        break;
      }
    }
    while (progress[col][row] != null &&
        progress[col][row]!.playerName == playerName &&
        col >= 0 &&
        row <= size - 1) {
      count++;
      col--;
      row++;
      if (col == -1 || row == size) {
        break;
      }
    }
    return count;
  }

  @override
  String toString() {
    return 'size: $size, winningCondition: $winningCondition';
  }
}
