import 'package:flutter/material.dart';
import 'package:flutter_directional_test/component/custom_push_button.dart';
import 'package:flutter_directional_test/screen/game_setting_screen.dart';
import 'package:flutter_directional_test/screen/replay_list_screen.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomPushButton(
              screen: GameSettingScreen(saves: saves),
              label: '게임 시작',
            ),
            const SizedBox(height: 16),
            CustomPushButton(
              screen: ReplayListScreen(saves: saves),
              label: '저장된 게임',
            ),
          ],
        ),
      ),
    );
  }
}
