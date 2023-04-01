import 'package:flutter/material.dart';

class PlayerStatus extends StatelessWidget {
  final String name;
  final int returnCount;
  final VoidCallback onPressed;

  const PlayerStatus({
    Key? key,
    required this.name,
    required this.returnCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 턴: $name'),
            const SizedBox(width: 16.0),
            Text('남은 무르기 횟수: $returnCount'),
            const SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text(
                '무르기',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
