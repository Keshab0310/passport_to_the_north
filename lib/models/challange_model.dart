class Challenge {
  final String name;
  final int exp;
  final String difficulty;
  bool isCompleted;

  Challenge({
    required this.name,
    required this.exp,
    required this.difficulty,
    this.isCompleted = false,
  });

  void markAsCompleted() {
    isCompleted = !isCompleted;
  }
}