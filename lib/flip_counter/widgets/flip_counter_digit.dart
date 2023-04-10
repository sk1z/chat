import 'package:flutter/material.dart';

class FlipCounterDigit extends StatelessWidget {
  const FlipCounterDigit({
    super.key,
    required this.width,
    required this.digit,
  });

  final double width;
  final int digit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text('$digit', textAlign: TextAlign.center),
    );
  }
}
