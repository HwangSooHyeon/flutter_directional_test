import 'package:flutter/material.dart';
import 'package:flutter_directional_test/screen/game_setting_screen.dart';
import 'package:flutter_directional_test/screen/replay_screen.dart';

import '../model/game_board.dart';

class HomeScreen extends StatelessWidget {
  final List<GameBoard> saves;

  const HomeScreen({
    Key? key,
    required this.saves,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameSettingScreen(
                      saves: saves,
                    ),
                  ),
                );
              },
              child: Text(
                '게임 시작',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReplayScreen(
                      saves: saves,
                    ),
                  ),
                );
              },
              child: Text(
                '저장된 게임',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
