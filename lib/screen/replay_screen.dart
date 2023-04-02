import 'package:flutter/material.dart';
import 'package:flutter_directional_test/component/custom_aligned_Icon.dart';
import 'package:flutter_directional_test/component/custom_app_bar.dart';
import 'package:flutter_directional_test/model/game_board.dart';

import '../const/const.dart';

class ReplayScreen extends StatelessWidget {
  final GameBoard gameBoard;

  const ReplayScreen({
    Key? key,
    required this.gameBoard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: replayScreenTitle),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text('승자: ${gameBoard.winner}'),
            ),
            const SizedBox(height: 16, width: double.maxFinite),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 4),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: gameBoard.size,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(
                      gameBoard.size * gameBoard.size,
                      (index) {
                        int col = index ~/ gameBoard.size;
                        int row = index % gameBoard.size;
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: Colors.yellow[700],
                            ),
                            if (gameBoard.progress[col][row] != null)
                              CustomAlignedIcon(
                                iconData:
                                    gameBoard.progress[col][row]!.iconData,
                              ),
                            if (gameBoard.progress[col][row] != null)
                              Positioned(
                                bottom: 0.0,
                                child: Container(
                                  color: Colors.white,
                                  child: Text(
                                    '${gameBoard.progress[col][row]!.turn}턴',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                      growable: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
