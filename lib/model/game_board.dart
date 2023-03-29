import 'mark.dart';

class GameBoard {
  final int size;
  late List<List<Mark?>> progress;
  late List<Mark> turns = <Mark>[];

  GameBoard({
    required this.size,
  }) {
    progress = List.generate(
      size,
      (index) => List.filled(size, null, growable: false),
      growable: false,
    );
  }
}
