import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_directional_test/model/game_board.dart';
import 'package:flutter_directional_test/model/player.dart';
import 'package:flutter_directional_test/screen/game_screen.dart';

class GameSettingScreen extends StatefulWidget {
  const GameSettingScreen({Key? key}) : super(key: key);

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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('게임판 사이즈 선택'),
            ListTile(
              title: Text('3 x 3'),
              leading: Radio<int>(
                value: 3,
                groupValue: _size,
                onChanged: (value) {
                  if (_winningCondition! > value!) {
                    setState(() {
                      _winningCondition = value;
                    });
                  }
                  setState(() {
                    _size = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('4 x 4'),
              leading: Radio<int>(
                value: 4,
                groupValue: _size,
                onChanged: (value) {
                  if (_winningCondition! > value!) {
                    setState(() {
                      _winningCondition = value;
                    });
                  }
                  setState(() {
                    _size = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('5 x 5'),
              leading: Radio<int>(
                value: 5,
                groupValue: _size,
                onChanged: (value) {
                  setState(() {
                    _size = value;
                  });
                },
              ),
            ),
            Text('승리 조건 선택'),
            ListTile(
              title: Text('3연속 연결'),
              leading: Radio<int>(
                value: 3,
                groupValue: _winningCondition,
                onChanged: (value) {
                  setState(() {
                    _winningCondition = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('4연속 연결'),
              leading: Radio<int>(
                value: 4,
                groupValue: _winningCondition,
                onChanged: (value) {
                  if (_size! < 4) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('연결 횟수는 크기보다 클 수 없습니다.'),
                        );
                      },
                    );
                  }
                  if (_size! >= 4) {
                    setState(() {
                      _winningCondition = value;
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: Text('5연속 연결'),
              leading: Radio<int>(
                value: 5,
                groupValue: _winningCondition,
                onChanged: (value) {
                  if (_size! < 5) {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('연결 횟수는 크기보다 클 수 없습니다.'),
                        );
                      },
                    );
                  }
                  if (_size! >= 5) {
                    setState(() {
                      _winningCondition = value;
                    });
                  }
                },
              ),
            ),
            Text('플레이어 이름 입력'),
            TextField(
              onChanged: (value) {
                _playerName1 = value;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                label: Text('플레이어1'),
                hintText: '플레이어 이름을 입력하세요.',
              ),
            ),
            TextField(
              onChanged: (value) {
                _playerName2 = value;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                label: Text('플레이어2'),
                hintText: '플레이어 이름을 입력하세요.',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_playerName1 == '' || _playerName2 == '') {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          '플레이어 이름을 입력해주세요.',
                        ),
                      );
                    },
                  );
                } else if (_playerName1.compareTo(_playerName2) == 0) {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          '플레이어 이름은 같을 수 없습니다.',
                        ),
                      );
                    },
                  );
                } else {
                  GameBoard gameBoard = GameBoard(
                      size: _size!, winningCondition: _winningCondition!);
                  bool randomFlag = Random().nextBool();
                  Player player1 = Player(
                    name: _playerName1,
                    isTurn: randomFlag,
                    iconData: randomFlag ? Icons.circle_outlined : Icons.close,
                  );
                  Player player2 = Player(
                    name: _playerName2,
                    isTurn: !randomFlag,
                    iconData: !randomFlag ? Icons.circle_outlined : Icons.close,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameScreen(
                          gameBoard: gameBoard,
                          player1: player1,
                          player2: player2),
                    ),
                  );
                }
              },
              child: Text(
                '게임 시작',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
