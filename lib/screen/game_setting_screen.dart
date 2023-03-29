import 'package:flutter/material.dart';

class GameSettingScreen extends StatefulWidget {
  const GameSettingScreen({Key? key}) : super(key: key);

  @override
  State<GameSettingScreen> createState() => _GameSettingScreenState();
}

class _GameSettingScreenState extends State<GameSettingScreen> {
  late int? _size = 3;
  late int _winningCondition;

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

          ],
        ),
      ),
    );
  }
}
