import 'dart:math';
import 'package:aphero/theme/app_colors_extension.dart';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final Color frontColor;
  final Color backColor;
  final IconData icon;
  final String label;
  final Color frontLabelColor;
  final Color backTextColor;
  final String question;

  const FlipCard({
    super.key,
    required this.frontColor,
    required this.backColor,
    required this.icon,
    required this.label,
    required this.frontLabelColor,
    required this.backTextColor,
    required this.question,
  });

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final double angle = _animation.value;

          final bool isFrontVisible = angle < pi / 2;

          final Matrix4 transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: isFrontVisible
                ?
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: widget.frontColor,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: appColors.textLight, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues( alpha: 0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(widget.icon, color: widget.frontLabelColor, size: 48),
                          const SizedBox(height: 10),
                          Text(
                            widget.label,
                            style: TextStyle(
                              color: widget.frontLabelColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : // Back side
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: widget.backColor,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: appColors.textLight, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.question,
                            style: TextStyle(
                              color: widget.backTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
