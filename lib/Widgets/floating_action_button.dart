import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget {
  final Future<void> Function() onPressed;

  const NavigateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        await onPressed(); // Ensures async logic works
      },
      label: const Text("Navigate Nearby"),
      icon: const Icon(Icons.directions),
    );
  }
}
