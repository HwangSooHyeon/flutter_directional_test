import 'package:flutter/material.dart';

class CustomPushButton extends StatelessWidget {
  final Widget screen;
  final String label;

  const CustomPushButton({
    Key? key,
    required this.screen,
    required this.label,
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
        minimumSize: const Size.fromHeight(55),
      ),
      child: Text(
        label,
      ),
    );
  }
}
