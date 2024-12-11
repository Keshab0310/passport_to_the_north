import 'package:flutter/material.dart';
import 'package:passport_to_the_north/models/user_model.dart';

class ExpProgressBar extends StatelessWidget {
  final int currentExp;
  final int totalExp;
  final League league;

  const ExpProgressBar({
    Key? key,
    required this.currentExp,
    required this.totalExp,
    required this.league,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressValue = currentExp / totalExp;

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'League: ${league.toString().split('.').last.toUpperCase()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              _getLeagueColor(league),
            ),
          ),
          Text('$currentExp / $totalExp XP'),
        ],
      ),
    );
  }

  Color _getLeagueColor(League league) {
    switch (league) {
      case League.bronze:
        return Colors.brown;
      case League.silver:
        return Colors.grey;
      case League.gold:
        return Colors.amber;
    }
  }
}