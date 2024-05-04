import 'package:flutter/material.dart';

class RefreshWordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double iconSize;
  final BorderSide borderSide;

  const RefreshWordButton({
    super.key,
    required this.onPressed,
    this.iconSize = 63,
    this.borderSide = const BorderSide(color: Colors.grey, width: 2),
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(7),
        side: const BorderSide(color: Colors.grey, width: 2)
      ),
      icon: const Icon(Icons.refresh),
      iconSize: 63,
      onPressed: onPressed,
      mouseCursor: MaterialStateMouseCursor.clickable,
    );
  }
}