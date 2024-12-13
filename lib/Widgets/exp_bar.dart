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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'League: ${league.toString().split('.').last.toUpperCase()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              Icon(
                Icons.emoji_events,
                color: _getLeagueColor(league),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: 20,
                width: progressValue * MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getLeagueColor(league).withOpacity(0.8),
                      _getLeagueColor(league),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$currentExp / $totalExp XP',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
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
      default:
        return Colors.blueGrey;
    }
  }
}
