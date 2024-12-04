import 'package:flutter/material.dart';

class ExpProgressBar extends StatelessWidget {
  final int currentExp;
  final int totalExp;
  final int level;

  const ExpProgressBar({
    super.key,
    required this.currentExp,
    required this.totalExp,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "EXP Progress: Level $level",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: currentExp / totalExp,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text("$currentExp / $totalExp EXP"),
        ],
      ),
    );
  }
}
