import 'package:flutter/material.dart';
import 'package:chat/flip_counter/flip_counter.dart';
import 'package:chat/styles/styles.dart';

class FlipCounter extends StatefulWidget {
  const FlipCounter({super.key, required this.value});

  final int value;

  @override
  State<FlipCounter> createState() => _FlipCounterState();
}

class _FlipCounterState extends State<FlipCounter> {
  int change = 0;

  @override
  void didUpdateWidget(covariant FlipCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    change = widget.value.compareTo(oldWidget.value);
  }

  @override
  Widget build(BuildContext context) {
    final FlipCounterStyle style =
        Theme.of(context).extension<FlipCounterStyle>()!;

    final EdgeInsetsGeometry padding = style.padding ?? EdgeInsets.zero;
    final MainAxisAlignment mainAxisAlignment =
        style.mainAxisAlignment ?? MainAxisAlignment.center;

    final TextStyle textStyle =
        DefaultTextStyle.of(context).style.merge(style.textStyle);
    final TextPainter prototypeDigit = TextPainter(
      text: TextSpan(text: '8', style: textStyle),
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout();
    final Color color = textStyle.color ?? Color(0xffff0000);

    final int? staticValue;
    final int? animatedValue;

    if (change == 0) {
      staticValue = widget.value;
      animatedValue = null;
    } else if (widget.value < 10 ||
        widget.value % 10 == 0 && change == 1 ||
        widget.value % 10 == 9 && change == -1) {
      staticValue = null;
      animatedValue = widget.value;
    } else {
      staticValue = widget.value ~/ 10;
      animatedValue = widget.value % 10;
    }

    List<Widget>? digits;

    if (staticValue != null) {
      digits = _getDigits(staticValue, prototypeDigit.size.width);
    }
    if (animatedValue != null) {
      final List<Widget> newDigits =
          _getDigits(animatedValue, prototypeDigit.size.width);
      final bool increased = change == 1;
      final int oldValue = animatedValue + (increased ? -1 : 1);
      final List<Widget> oldDigits =
          _getDigits(oldValue, prototypeDigit.size.width);
      final Widget counter = AnimatedFlipCounter(
        digits: newDigits,
        oldDigits: oldDigits,
        increased: increased,
        size: prototypeDigit.size,
        color: color,
      );
      if (digits != null) {
        digits.add(counter);
      } else {
        digits = [counter];
      }
    }

    return Padding(
      padding: padding,
      child: DefaultTextStyle.merge(
        style: textStyle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: digits ?? [],
        ),
      ),
    );
  }

  List<Widget> _getDigits(int value, double width) {
    List<int> digits = value == 0 ? [0] : [];
    int v = value;
    while (v > 0) {
      digits.add(v % 10);
      v = v ~/ 10;
    }
    digits = digits.reversed.toList(growable: false);

    final List<Widget> digitWidgets = [];
    for (int i = 0; i < digits.length; i++) {
      final Widget digit = FlipCounterDigit(
        width: width,
        digit: digits[i],
      );
      digitWidgets.add(digit);
    }
    return digitWidgets;
  }
}
