import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  // Color Palette
  final Color primaryGreen = const Color(0xFF2E8B57);
  final Color primaryYellow = const Color(0xFFFFD600);
  final Color primaryBrown = const Color(0xFF795548);
  final Color accentBrown = const Color(0xFF8B4513);
  final Color lightGreen = const Color(0xFF9E9D24);
  final Color lightBrown = const Color(0xFFD7CCC8);
  final Color lightYellow = const Color(0xFFFFFDE7);

  // Medal Colors
  final Color bronzeColor = const Color(0xFFCD7F32);
  final Color silverColor = const Color(0xFFC0C0C0);
  final Color goldColor = const Color(0xFFFFD700);

  // User Progress Data (Mock)
  final Map<String, int> userProgress = {
    'Explorer': 12,
    'Hiker': 20,
    'Photographer': 8
  };

  // Medal Levels
  String getMedalLevel(int points) {
    if (points >= 30) return 'Gold';
    if (points >= 15) return 'Silver';
    return 'Bronze';
  }

  Widget _buildProgressCard() {
    return Card(
      elevation: 4,
      color: lightYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryBrown,
              ),
            ),
            const SizedBox(height: 10),
            ...userProgress.entries.map((entry) {
              String medalLevel = getMedalLevel(entry.value);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key, // Achievement name
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          '${entry.value} Points', // Points or progress value
                          style: TextStyle(fontSize: 16, color: primaryBrown),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          medalLevel == 'Gold'
                              ? Icons.star
                              : medalLevel == 'Silver'
                                  ? Icons.star_border
                                  : Icons.star_outline,
                          color: medalLevel == 'Gold'
                              ? goldColor
                              : medalLevel == 'Silver'
                                  ? silverColor
                                  : bronzeColor,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Card(
      elevation: 4,
      color: lightYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Achievements',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryBrown,
              ),
            ),
            const SizedBox(height: 10),
            _buildAchievementBadge(
              icon: FontAwesomeIcons.medal,
              title: 'Gold',
              description: 'Get silver badge first.',
              isUnlocked: true,
            ),
            _buildAchievementBadge(
              icon: FontAwesomeIcons.medal,
              title: 'Silver',
              description: 'Get bronze badge first.',
              isUnlocked: true,
            ),
            _buildAchievementBadge(
              icon: FontAwesomeIcons.medal,
              title: 'Bronze',
              description: 'Complete your daily challenges.',
              isUnlocked: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesSection() {
    return Card(
      elevation: 4,
      color: lightYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Challenges',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryBrown,
              ),
            ),
            const SizedBox(height: 10),
            // Example achievement items
            _buildChallengesBadge(
              icon: FontAwesomeIcons.personWalking,
              title: 'Walk',
              description: 'Explore 2km.',
              isUnlocked: true,
            ),
            _buildChallengesBadge(
              icon: FontAwesomeIcons.photoFilm,
              title: 'Photography',
              description: 'Click 3 pictures per day.',
              isUnlocked: true,
            ),
            _buildChallengesBadge(
              icon: FontAwesomeIcons.instagram,
              title: 'Social Media',
              description: 'Share a post in social media with our hashtag.',
              isUnlocked: true,
            ),
          ],
        ),
      ),
    );
  }

  // Companion method for building individual achievement badges
  Widget _buildAchievementBadge({
    required IconData icon,
    required String title,
    required String description,
    required bool isUnlocked,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Achievement Icon
          Container(
            decoration: BoxDecoration(
              color:
                  isUnlocked ? primaryGreen.withOpacity(0.2) : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              color: isUnlocked ? Colors.amber : Colors.grey,
              size: 30,
            ),
          ),
          const SizedBox(width: 15),

          // Achievement Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.black : Colors.grey,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUnlocked ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Lock/Unlock Indicator
          Icon(
            isUnlocked ? Icons.check_circle : Icons.lock,
            color: isUnlocked ? primaryGreen : Colors.grey,
          ),
        ],
      ),
    );
  }

  // Companion method for building individual challenge badges
  Widget _buildChallengesBadge({
    required IconData icon,
    required String title,
    required String description,
    required bool isUnlocked,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Achievement Icon
          Container(
            decoration: BoxDecoration(
              color:
                  isUnlocked ? primaryGreen.withOpacity(0.2) : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              color: isUnlocked ? Colors.amber : Colors.grey,
              size: 30,
            ),
          ),
          const SizedBox(width: 15),

          // Achievement Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.black : Colors.grey,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isUnlocked ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Lock/Unlock Indicator
          Icon(
            isUnlocked ? Icons.check_circle : Icons.lock,
            color: isUnlocked ? primaryGreen : Colors.grey,
          ),
        ],
      ),
    );
  }

  // Launch external URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      appBar: AppBar(
        title: const Text(
          'My Progress',
          style: TextStyle(
            fontSize: 26,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryBrown,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _launchURL('https://example.com/share'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressCard(),
              const SizedBox(height: 13),
              const SizedBox(height: 20),
              _buildAchievementsSection(),
              const SizedBox(height: 13),
              _buildChallengesSection()
            ],
          ),
        ),
      ),
    );
  }
}
