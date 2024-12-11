import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NavigateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: const Text("Navigate Nearby"),
      icon: const Icon(Icons.directions),

    );
  }
}
