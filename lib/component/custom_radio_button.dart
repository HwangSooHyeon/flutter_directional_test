import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final int value;
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  const CustomRadioButton({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: Radio<int>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
