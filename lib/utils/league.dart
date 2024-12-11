import 'package:flutter/material.dart';

enum LeagueType {
  bronze,
  silver,
  gold
}

extension LeagueExtension on LeagueType {
  String get displayName {
    switch (this) {
      case LeagueType.bronze:
        return 'Bronze';
      case LeagueType.silver:
        return 'Silver';
      case LeagueType.gold:
        return 'Gold';
    }
  }

  Color get color {
    switch (this) {
      case LeagueType.bronze:
        return Colors.brown;
      case LeagueType.silver:
        return Colors.grey;
      case LeagueType.gold:
        return Colors.amber;
    }
  }
}

class UserModel {
  String userId;
  LeagueType league;
  int points;
  List<String> achievements;

  UserModel({
    required this.userId,
    this.league = LeagueType.bronze,
    this.points = 0,
    this.achievements = const [],
  });

  // JSON Serialization
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'league': league.toString().split('.').last,
    'points': points,
    'achievements': achievements,
  };

  // JSON Deserialization
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['userId'],
    league: LeagueType.values.firstWhere(
            (e) => e.toString().split('.').last == json['league'],
        orElse: () => LeagueType.bronze
    ),
    points: json['points'] ?? 0,
    achievements: List<String>.from(json['achievements'] ?? []),
  );
}