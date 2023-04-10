import 'dart:math';

import 'package:flutter/material.dart';

const Duration _duration = const Duration(milliseconds: 130);

const Curve _curve = Curves.linear;

class AnimatedFlipCounter extends StatefulWidget {
  const AnimatedFlipCounter({
    super.key,
    required this.digits,
    required this.oldDigits,
    required this.increased,
    required this.size,
    required this.color,
  });

  final List<Widget> digits;
  final List<Widget> oldDigits;
  final bool increased;
  final Size size;
  final Color color;

  @override
  State<AnimatedFlipCounter> createState() => _AnimatedFlipCounterState();
}

class _AnimatedFlipCounterState extends State<AnimatedFlipCounter>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: _duration,
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: _curve,
  );

  @override
  void didUpdateWidget(covariant AnimatedFlipCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller
      ..value = 0
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.size.width;
    final double height = widget.size.height;

    return SizedBox(
      width: width * max(widget.digits.length, widget.oldDigits.length),
      height: height,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              _buildDigitRow(
                digits: widget.digits,
                offset: widget.increased
                    ? height * _animation.value - height
                    : height - height * _animation.value,
                opacity: _animation.value,
              ),
              _buildDigitRow(
                digits: widget.oldDigits,
                offset: widget.increased
                    ? height * _animation.value
                    : -height * _animation.value,
                opacity: 1 - _animation.value,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDigitRow({
    required List<Widget> digits,
    required double offset,
    required double opacity,
  }) {
    return DefaultTextStyle.merge(
      style: TextStyle(color: widget.color.withOpacity(opacity.clamp(0, 1))),
      child: Positioned(
        top: offset,
        child: Row(children: digits),
      ),
    );
  }
}
