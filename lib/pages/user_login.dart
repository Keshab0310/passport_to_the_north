import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:passport_to_the_north/pages/home_page.dart';
import 'package:passport_to_the_north/Widgets/user_model.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> _authUser(LoginData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );

      final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (!userDoc.exists) {
        return 'No user data found in Firestore.';
      }

      debugPrint("User data: ${userDoc.data()}");
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password.';
      }
      return e.message;
    }
  }

  Future<String?> _authSignup(SignupData data) async {
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(data.name!)) {
      return 'Enter a valid email.';
    }
    if (data.password!.length < 6) {
      return 'Password should be at least 6 characters.';
    }
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );

      final userDoc = FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid);

      await userDoc.set({
        'uid': userCredential.user!.uid,
        'email': data.name!,
        'username': data.additionalSignupData?['username'] ?? 'Anonymous',
        'createdAt': FieldValue.serverTimestamp(),
        'currentExp': 0,
        'totalExp': 1000,
        'league': League.bronze.toString().split('.').last,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'This email is already registered.';
      }
      return e.message;
    } catch (e) {
      return 'An error occurred. Please try again later.';
    }
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: name);
      return 'Password reset email sent!';
    } catch (e) {
      return 'Failed to send password reset email.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Welcome to the North',
      logo: "assets/logo.jpg",
      onLogin: (LoginData data) async {
            final result = await _authUser(data);
            if (result == null) {
              AppUser? currentUser;
              try {
                final firebaseUser = FirebaseAuth.instance.currentUser;
                if (firebaseUser != null) {
                  final docSnapshot = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(firebaseUser.uid)
                      .get();

                  if (docSnapshot.exists) {
                    currentUser = User(
                      id: docSnapshot.id,
                      username: docSnapshot['username'] as String,
                      email: docSnapshot['email'] as String,
                      currentExp: docSnapshot['currentExp'] as int,
                      totalExp: docSnapshot['totalExp'] as int,
                      league: League.values.firstWhere(
                              (e) => e.toString().split('.').last == docSnapshot['league']
                      ),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(user: currentUser!),
                      ),
                    );
                  }
                }
              } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error fetching user data: ${e.toString()}')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        }
        return result;
      },
      onSignup: _authSignup,
      onRecoverPassword: _recoverPassword,
      additionalSignupFields: const [
        UserFormField(
          keyName: 'username',
          displayName: 'Username',
          icon: Icon(Icons.person),
        ),
      ],
      theme: LoginTheme(
        primaryColor: Colors.brown,
        accentColor: Colors.yellow,
        titleStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      ),
    );
  }
}