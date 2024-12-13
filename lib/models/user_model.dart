enum League {
  bronze,
  silver,
  gold,
}

class AppUser {
  final String id;
  final String username;
  final String email;
  int currentExp;
  int totalExp;
  League league;

  AppUser({
    required this.id,
    required this.username,
    required this.email,
    this.currentExp = 0,
    this.totalExp = 200,
    this.league = League.bronze,
  });

  void updateExperience(int expGained) {
    currentExp += expGained;

    // League progression logic
    if (currentExp >= totalExp) {
      switch (league) {
        case League.bronze:
          if (currentExp >= 1000) {
            league = League.silver;
            // totalExp = 2000;
            // currentExp -= 1000;
          }
          break;
        case League.silver:
          if (currentExp >= 2000) {
            league = League.gold;
            // totalExp = 3000;
            // currentExp -= 2000;
          }
          break;
        case League.gold:
          currentExp = totalExp;
          break;
      }
    }
  }
}