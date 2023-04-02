import 'package:flutter/material.dart';
import 'package:flutter_directional_test/component/custom_app_bar.dart';
import 'package:flutter_directional_test/component/custom_push_button.dart';
import 'package:flutter_directional_test/screen/replay_screen.dart';

import '../const/const.dart';
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
      appBar: const CustomAppBar(title: replayListScreenTitle),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          saves.length,
          (index) => ListTile(
            leading: Text('승자: ${saves[index].winner}'),
            title: Text('종료시간: ${saves[index].endTime}'),
            trailing: CustomPushButton(
              screen: ReplayScreen(gameBoard: saves[index]),
              label: '보기',
              minimumSize: null,
            ),
          ),
        ),
      ),
    );
  }
}
