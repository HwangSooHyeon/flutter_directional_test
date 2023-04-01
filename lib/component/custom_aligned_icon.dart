import 'package:flutter/material.dart';

class CustomAlignedIcon extends StatelessWidget {
  final IconData iconData;

  const CustomAlignedIcon({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Icon(
        iconData,
        size: 72,
        color: Colors.black,
      ),
    );
  }
}
