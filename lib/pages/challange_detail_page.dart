import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  final Map<String, dynamic> challenge;

  const ChallengeDetailPage({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge: ${challenge['name']} '),
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(challenge['name'],
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ),
        ),
          const SizedBox(height: 10,),
          Text(challenge['description'],
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal
            ),),
      const SizedBox(height: 10),
      Text(
        "Status: ${challenge['isCompleted'] ? "Completed" : "Not Completed"}",
        style: TextStyle(
          fontSize: 18,
          color: challenge['isCompleted'] ? Colors.green : Colors.red,
        ),)
        ],
      ),
    );
  }
}
