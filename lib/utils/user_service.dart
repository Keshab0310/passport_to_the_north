import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:passport_to_the_north/models/user_model.dart';

class UserService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current logged-in user
  Future<firebase_auth.User?> getCurrentFirebaseUser() async {
    return _auth.currentUser;
  }

  // Fetch user details from Firestore
  Future<AppUser?> fetchUserDetails() async {
    firebase_auth.User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;

    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (userDoc.exists) {
        return AppUser(
          id: firebaseUser.uid,
          username: userDoc['username'] ?? firebaseUser.displayName ?? 'User',
          email: firebaseUser.email!,
          currentExp: userDoc['currentExp'] ?? 0,
          totalExp: userDoc['totalExp'] ?? 1000,
          league: _convertStringToLeague(userDoc['league'] ?? 'bronze'),
        );
      }
      return null;
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  // Convert string to League enum
  League _convertStringToLeague(String leagueString) {
    switch (leagueString.toLowerCase()) {
      case 'silver':
        return League.silver;
      case 'gold':
        return League.gold;
      default:
        return League.bronze;
    }
  }

  // Update user experience in Firestore
  Future<void> updateUserExperience(AppUser user) async {
    try {
      await _firestore.collection('users').doc(user.id).update({
        'currentExp': user.currentExp,
        'totalExp': user.totalExp,
        'league': user.league.toString().split('.').last,
      });
    } catch (e) {
      debugPrint('Error updating user experience: $e');
    }
  }

  // Login method
  Future<firebase_auth.User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      firebase_auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      debugPrint('Login error: $e');
      return null;
    }
  }

  // Logout method
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
