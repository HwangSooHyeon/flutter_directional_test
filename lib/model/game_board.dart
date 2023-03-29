import 'mark.dart';

class GameBoard {
  final int size;
  final int winningCondition;
  late List<List<Mark?>> progress;
  List<Mark> turns = <Mark>[];

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

  @override
  String toString() {
    return 'size: $size, winningCondition: $winningCondition';
  }
}
