import 'package:flutter/material.dart';
import 'package:flutter_directional_test/model/game_board.dart';
import 'package:flutter_directional_test/model/mark.dart';
import 'package:flutter_directional_test/model/player.dart';

class GameScreen extends StatefulWidget {
  final GameBoard gameBoard;
  final Player player1;
  final Player player2;
  List<GameBoard> saves;

  GameScreen({
    Key? key,
    required this.gameBoard,
    required this.player1,
    required this.player2,
    required this.saves,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<bool> isTapped;
  late List<String> whoTapped;
  List<int> history = [];
  int turn = 1;
  int saveFlag = 0;

  @override
  void initState() {
    setState(() {});
    isTapped =
        List.filled(widget.gameBoard.size * widget.gameBoard.size, false);
    whoTapped = List.filled(widget.gameBoard.size * widget.gameBoard.size, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Playing',
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
              child: Text('현재 턴: $turn'),
            ),
            if (widget.player1.isTurn)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('당신의 턴: ${widget.player1.name}'),
                      const SizedBox(width: 16.0),
                      Text('남은 무르기 횟수: ${widget.player1.returnCount}'),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (turn < 2) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('2턴이 지나야 가능합니다.'),
                                );
                              },
                            );
                            return;
                          }
                          if (widget.player1.returnCount == 0) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('무르기 횟수가 0입니다.'),
                                );
                              },
                            );
                            return;
                          }
                          setState(() {
                            widget.player1.decReturnCount();
                            for (int i = 0; i < 2; i++) {
                              isTapped[history.last] = false;
                              whoTapped[history.last] = '';
                              history.removeLast();
                            }
                            widget.gameBoard.doReturn();
                            turn -= 2;
                          });
                        },
                        child: Text(
                          '무르기',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (widget.player2.isTurn)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('당신의 턴: ${widget.player2.name}'),
                      const SizedBox(width: 16.0),
                      Text('남은 무르기 횟수: ${widget.player2.returnCount}'),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          if (turn < 2) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('2턴이 지나야 가능합니다.'),
                                );
                              },
                            );
                            return;
                          }
                          if (widget.player2.returnCount == 0) {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('무르기 횟수가 0입니다.'),
                                );
                              },
                            );
                            return;
                          }
                          setState(() {
                            widget.player2.decReturnCount();
                            for (int i = 0; i < 2; i++) {
                              isTapped[history.last] = false;
                              whoTapped[history.last] = '';
                              history.removeLast();
                            }
                            widget.gameBoard.doReturn();
                            turn -= 2;
                          });
                        },
                        child: Text(
                          '무르기',
                        ),
                      ),
                    ],
                  ),
                ],
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
                    crossAxisCount: widget.gameBoard.size,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(
                      widget.gameBoard.size * widget.gameBoard.size,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            if (isTapped[index] && whoTapped.isNotEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text('이미 둔 자리 입니다.'),
                                  );
                                },
                              );
                              return;
                            }
                            setState(() {
                              isTapped[index] = true;
                              history.add(index);
                              if (widget.player1.isTurn) {
                                whoTapped[index] = widget.player1.name;
                                Mark mark = Mark(
                                    playerName: widget.player1.name,
                                    iconData: widget.player1.iconData,
                                    turn: turn,
                                    index: index);
                                widget.gameBoard.addHistory(mark);
                                widget.gameBoard.addProgress(mark, index);
                              }
                              if (widget.player2.isTurn) {
                                whoTapped[index] = widget.player2.name;
                                Mark mark = Mark(
                                    playerName: widget.player2.name,
                                    iconData: widget.player2.iconData,
                                    turn: turn,
                                    index: index);
                                widget.gameBoard.addHistory(mark);
                                widget.gameBoard.addProgress(mark, index);
                              }
                              String result = widget.gameBoard.checkEnd();
                              if (result != 'proceed') {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: result == 'draw'
                                          ? Text(
                                              '무승부 입니다.',
                                            )
                                          : Text(
                                              '승자: $result',
                                            ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if (saveFlag == 0) {
                                              widget.saves.add(widget.gameBoard);
                                              saveFlag = 1;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '저장되었습니다.',
                                                  ),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '이미 저장된 게임입니다.',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            '게임저장',
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '다시시작',
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            '타이틀로',
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              }
                              turn++;
                              widget.player1.setTurn();
                              widget.player2.setTurn();
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                color: Colors.yellow[700],
                              ),
                              if (isTapped[index] &&
                                  whoTapped[index] == widget.player1.name)
                                Icon(
                                  widget.player1.iconData,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              if (isTapped[index] &&
                                  whoTapped[index] == widget.player2.name)
                                Icon(
                                  widget.player2.iconData,
                                  size: 24,
                                  color: Colors.black,
                                ),
                            ],
                          ),
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
