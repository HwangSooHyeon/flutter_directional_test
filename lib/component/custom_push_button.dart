import 'package:flutter/material.dart';

class CustomPushButton extends StatelessWidget {
  final Widget screen;
  final String label;
  final Size? minimumSize;

  const CustomPushButton({
    Key? key,
    required this.screen,
    required this.label,
    this.minimumSize = const Size.fromHeight(55),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: minimumSize,
      ),
      child: Text(
        label,
      ),
    );
  }
}
