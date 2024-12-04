import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:passport_to_the_north/home_page.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'This email is already registered.';
      }
      return e.message;
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
          // Navigate to MapNavigationPage upon successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
        return result;
      },
      onSignup: _authSignup,
      onRecoverPassword: _recoverPassword,
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
