import 'package:flutter/material.dart';
import 'package:flutter_directional_test/screen/replay_screen.dart';

import '../model/game_board.dart';

class ReplayListScreen extends StatelessWidget {
  final List<GameBoard> saves;

  const ReplayListScreen({
    Key? key,
    required this.saves,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          saves.length,
          (index) => ListTile(
            leading: Text('승자: ${saves[index].winner}'),
            title: Text('종료시간: ${saves[index].endTime}'),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReplayScreen(
                      gameBoard: saves[index],
                    ),
                  ),
                );
              },
              child: Text(
                '보기',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
