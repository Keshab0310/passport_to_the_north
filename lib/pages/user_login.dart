// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:passport_to_the_north/Widgets/drawer_navigation.dart';

// Import necessary models and pages
import 'package:passport_to_the_north/models/user_model.dart';
import 'package:passport_to_the_north/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login Method
  Future<String?> _loginUser(LoginData loginData) async {
    try {
      // Attempt Firebase Authentication
      final userCredential = await fb_auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      );

      // Fetch user details from Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        return 'User data not found';
      }

      return null; // Successful login
    } on fb_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No user found with this email';
        case 'wrong-password':
          return 'Incorrect password';
        default:
          return 'Login failed: ${e.message}';
      }
    }
  }

  // Signup Method
  Future<String?> _signupUser(SignupData signupData) async {
    try {
      // Validate email
      if (!_isValidEmail(signupData.name ?? '')) {
        return 'Invalid email format';
      }

      // Validate password
      if ((signupData.password ?? '').length < 6) {
        return 'Password must be at least 6 characters';
      }

      // Create user in Firebase Authentication
      final userCredential = await fb_auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: signupData.name!,
        password: signupData.password!,
      );

      // Create user document in Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': signupData.name,
        'username': signupData.additionalSignupData?['username'] ?? 'Explorer',
        'currentExp': 0,
        'totalExp': 1000,
        'league': League.bronze.name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null; // Successful signup
    } on fb_auth.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email already registered';
        default:
          return 'Signup failed: ${e.message}';
      }
    }
  }

  // Password Recovery Method
  Future<String?> _recoverPassword(String email) async {
    try {
      await fb_auth.FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Password reset email sent';
    } catch (e) {
      return 'Password reset failed';
    }
  }

  // Email Validation Method
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Navigate to HomePage after successful login
  void _navigateToHomePage(BuildContext context) async {
    final currentUser = fb_auth.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        final appUser = AppUser(
          id: currentUser.uid,
          username: userDoc['username'],
          email: currentUser.email!,
          currentExp: userDoc['currentExp'],
          totalExp: userDoc['totalExp'],
          league: League.values.byName(userDoc['league']),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(user: appUser), // Change this line
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'Passport to the North',
        logo: const AssetImage('assets/logo.jpg'), // Make sure to add your logo
        onLogin: _loginUser,
        onSignup: _signupUser,
        onRecoverPassword: _recoverPassword,
        additionalSignupFields: const [
          UserFormField(
            keyName: 'username',
            displayName: 'Username',
            icon:  Icon(Icons.person),
          ),
        ],
        onSubmitAnimationCompleted: () => _navigateToHomePage(context),
        theme: LoginTheme(
          primaryColor: Colors.brown,
          accentColor: Colors.yellow,
          titleStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}
