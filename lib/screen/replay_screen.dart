import 'package:flutter/material.dart';
import 'package:flutter_directional_test/model/game_board.dart';

class ReplayScreen extends StatelessWidget {
  final GameBoard gameBoard;

  const ReplayScreen({
    Key? key,
    required this.gameBoard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Replay',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          splashRadius: 0.1,
        ),
      ),
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
            Container(
              height: 16,
              color: Colors.white,
            ),
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
                              Icon(
                                gameBoard.progress[col][row]!.iconData,
                                size: 96,
                                color: Colors.black,
                              ),
                            if (gameBoard.progress[col][row] != null)
                              Positioned(
                                bottom: 0.0,
                                child: Container(
                                  color: Colors.white,
                                  child: Text(
                                    '${gameBoard.progress[col][row]!.turn}턴',
                                    style: TextStyle(
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
