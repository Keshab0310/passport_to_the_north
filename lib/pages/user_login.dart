import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  // The below code will manage the authentication of Email and Password with Firebase during login.

  Future<String?> _authUser(LoginData data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // The below code will manage the authentication of Email and Password with Firebase during signup.
  // We can even say that it will create the email and passwod for new user duiring signup.
  Future<String?> _authSignup(SignupData data) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      if (data.name == 'existing@example.com') {
        return 'User already exists';
      }
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // The below code is for the recovery of the Password with the use of emial.
  Future<String?> _recoverPassword(String name) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: name);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Welcome to the North',
      logo: "assets/logo.jpg",
      onLogin: _authUser, // Function for login
      onSignup: _authSignup, // New function for signup
      onRecoverPassword: _recoverPassword, // Function for password recovery
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
