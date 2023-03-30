import 'mark.dart';

class GameBoard {
  final int size;
  final int winningCondition;
  late List<List<Mark?>> progress;
  List<Mark> history = <Mark>[];

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

  @override
  String toString() {
    return 'size: $size, winningCondition: $winningCondition';
  }
}
