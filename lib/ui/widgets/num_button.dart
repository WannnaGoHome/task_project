
import 'package:flutter/material.dart';

class NumButton extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;

  const NumButton({
    super.key,
    required this.number,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        number.toString(),
        style: const TextStyle(
          fontSize: 24,
          color: Colors.pinkAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}