import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_directional_test/component/custom_app_bar.dart';
import 'package:flutter_directional_test/component/custom_radio_button.dart';
import 'package:flutter_directional_test/component/custom_text_field.dart';
import 'package:flutter_directional_test/model/game_board.dart';
import 'package:flutter_directional_test/model/player.dart';
import 'package:flutter_directional_test/screen/game_screen.dart';
import 'package:flutter_directional_test/util/functions.dart';

import '../const/const.dart';

class GameSettingScreen extends StatefulWidget {
  final List<GameBoard> saves;

  const GameSettingScreen({
    Key? key,
    required this.saves,
  }) : super(key: key);

  @override
  State<GameSettingScreen> createState() => _GameSettingScreenState();
}

class _GameSettingScreenState extends State<GameSettingScreen> {
  late int? _size = 3;
  late int? _winningCondition = 3;
  String _playerName1 = '';
  String _playerName2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: gameSettingScreenTitle),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 4,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('게임판 사이즈 선택'),
            CustomRadioButton(
              label: '3 x 3',
              value: size3By3,
              groupValue: _size,
              onChanged: (value) {
                _sizeValidation(value);
                _setSize(value);
              },
            ),
            CustomRadioButton(
              label: '4 x 4',
              value: size4By4,
              groupValue: _size,
              onChanged: (value) {
                _sizeValidation(value);
                _setSize(value);
              },
            ),
            CustomRadioButton(
              label: '5 x 5',
              value: size5By5,
              groupValue: _size,
              onChanged: (value) {
                _setSize(value);
              },
            ),
            const Text('승리 조건 선택'),
            CustomRadioButton(
              label: '3연속 연결',
              value: continuous3,
              groupValue: _winningCondition,
              onChanged: (value) {
                _setWinningCondition(value);
              },
            ),
            CustomRadioButton(
              label: '4연속 연결',
              value: continuous4,
              groupValue: _winningCondition,
              onChanged: (value) {
                if (_size! < continuous4) {
                  showSimpleAlertDialog(context, '연결 횟수는 크기보다 클 수 없습니다.');
                  return;
                }
                _setWinningCondition(value);
              },
            ),
            CustomRadioButton(
              label: '5연속 연결',
              value: continuous5,
              groupValue: _winningCondition,
              onChanged: (value) {
                if (_size! < continuous5) {
                  showSimpleAlertDialog(context, '연결 횟수는 크기보다 클 수 없습니다.');
                  return;
                }
                _setWinningCondition(value);
              },
            ),
            const Text('플레이어 이름 입력'),
            CustomTextField(
              label: '플레이어1',
              hint: '플레이어 이름을 입력하세요.',
              onChanged: (value) {
                _playerName1 = value;
              },
            ),
            CustomTextField(
              label: '플레이어2',
              hint: '플레이어 이름을 입력하세요.',
              onChanged: (value) {
                _playerName2 = value;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_playerName1 == '' || _playerName2 == '') {
                  showSimpleAlertDialog(context, '플레이어 이름을 입력해주세요.');
                  return;
                }
                if (_playerName1.compareTo(_playerName2) == 0) {
                  showSimpleAlertDialog(context, '플레이어 이름은 같을 수 없습니다.');
                  return;
                }
                bool randomFlag = Random().nextBool();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameScreen(
                      gameBoard: _createGameBoard(),
                      player1: _createPlayer(_playerName1, randomFlag),
                      player2: _createPlayer(_playerName2, !randomFlag),
                      saves: widget.saves,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55),
              ),
              child: const Text(
                '게임 시작',
              ),
            ),
          ],
        ),
      ),
    );
  }

  GameBoard _createGameBoard() {
    return GameBoard(
      size: _size!,
      winningCondition: _winningCondition!,
    );
  }

  Player _createPlayer(String playerName, bool randomFlag) {
    return Player(
      name: playerName,
      isTurn: randomFlag,
      iconData: randomFlag ? Icons.circle_outlined : Icons.close,
    );
  }

  void _sizeValidation(int? value) {
    if (_winningCondition! > value!) {
      setState(() {
        _winningCondition = value;
      });
    }
  }

  void _setSize(int? value) {
    setState(() {
      _size = value;
    });
  }

  void _setWinningCondition(int? value) {
    setState(() {
      _winningCondition = value;
    });
  }
}
