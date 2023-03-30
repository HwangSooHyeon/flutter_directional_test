import 'package:flutter/material.dart';
import 'package:flutter_directional_test/model/game_board.dart';
import 'package:flutter_directional_test/model/player.dart';

class GameScreen extends StatefulWidget {
  final GameBoard gameBoard;
  final Player player1;
  final Player player2;

  const GameScreen({
    Key? key,
    required this.gameBoard,
    required this.player1,
    required this.player2,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<bool> isTapped;
  late List<String> whoTapped;

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                            setState(() {
                              isTapped[index] = true;
                              widget.player1.isTurn
                                  ? whoTapped[index] = widget.player1.name
                                  : whoTapped[index] = widget.player2.name;
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
                              if (isTapped[index] && whoTapped[index] == widget.player1.name)
                                Icon(
                                  widget.player1.iconData,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              if (isTapped[index] && whoTapped[index] == widget.player2.name)
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
