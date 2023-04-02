import 'package:flutter/material.dart';
import 'package:flutter_directional_test/component/custom_aligned_icon.dart';
import 'package:flutter_directional_test/component/custom_app_bar.dart';
import 'package:flutter_directional_test/component/player_status.dart';
import 'package:flutter_directional_test/model/game_board.dart';
import 'package:flutter_directional_test/model/mark.dart';
import 'package:flutter_directional_test/model/player.dart';
import 'package:flutter_directional_test/util/functions.dart';

import '../const/const.dart';

class GameScreen extends StatefulWidget {
  final GameBoard gameBoard;
  final Player player1;
  final Player player2;
  final List<GameBoard> saves;

  const GameScreen({
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
    isTapped =
        List.filled(widget.gameBoard.size * widget.gameBoard.size, false);
    whoTapped = List.filled(widget.gameBoard.size * widget.gameBoard.size, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: gameScreenTitle),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text('현재 턴: $turn'),
          ),
          if (widget.player1.isTurn)
            PlayerStatus(
              name: widget.player1.name,
              returnCount: widget.player1.returnCount,
              onPressed: () {
                if (turn < 3) {
                  showSimpleAlertDialog(context, '3턴 부터 가능합니다.');
                  return;
                }
                if (widget.player1.returnCount == 0) {
                  showSimpleAlertDialog(context, '무르기 횟수가 0입니다.');
                  return;
                }
                widget.player1.decReturnCount();
                _doReturn();
              },
            ),
          if (widget.player2.isTurn)
            PlayerStatus(
              name: widget.player2.name,
              returnCount: widget.player2.returnCount,
              onPressed: () {
                if (turn < 3) {
                  showSimpleAlertDialog(context, '3턴 부터 가능합니다.');
                  return;
                }
                if (widget.player2.returnCount == 0) {
                  showSimpleAlertDialog(context, '무르기 횟수가 0입니다.');
                  return;
                }
                widget.player2.decReturnCount();
                _doReturn();
              },
            ),
          const SizedBox(height: 16, width: double.maxFinite),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 4,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
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
                            showSimpleAlertDialog(context, '이미 둔 자리 입니다.');
                            return;
                          }
                          setState(() {
                            isTapped[index] = true;
                            history.add(index);
                            _addMarkInGameBoard(widget.player1, index);
                            _addMarkInGameBoard(widget.player2, index);
                            String gameResult = widget.gameBoard.checkEnd();
                            if (gameResult != proceed) {
                              widget.gameBoard.setWinner(gameResult);
                              widget.gameBoard.setEndTime();
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    content: gameResult == draw
                                        ? const Text('무승부 입니다.')
                                        : Text('승자: $gameResult'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (saveFlag == 0) {
                                            widget.saves.add(widget.gameBoard);
                                            saveFlag = 1;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('저장되었습니다.'),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('이미 저장된 게임입니다.'),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text('게임저장'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('다시시작'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                        },
                                        child: const Text('타이틀로'),
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
                              CustomAlignedIcon(
                                iconData: widget.player1.iconData,
                              ),
                            if (isTapped[index] &&
                                whoTapped[index] == widget.player2.name)
                              CustomAlignedIcon(
                                iconData: widget.player2.iconData,
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
    );
  }

  void _doReturn() {
    setState(() {
      for (int i = 0; i < 2; i++) {
        isTapped[history.last] = false;
        whoTapped[history.last] = '';
        history.removeLast();
      }
      widget.gameBoard.doReturn();
      turn -= 2;
    });
  }

  void _addMarkInGameBoard(Player player, int index) {
    if (player.isTurn) {
      whoTapped[index] = player.name;
      Mark mark = Mark(
          playerName: player.name,
          iconData: player.iconData,
          turn: turn,
          index: index);
      widget.gameBoard.addHistory(mark);
      widget.gameBoard.addProgress(mark, index);
    }
  }
}
