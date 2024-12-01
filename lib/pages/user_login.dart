import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Username: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (data.name != 'user@example.com' || data.password != 'password') {
        return 'Username or password is incorrect';
      }
      return null;
    });
  }

  Future<String?> _authSignup(SignupData data) {
    debugPrint('Signup - Username: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (data.name == 'existing@example.com') {
        return 'User already exists';
      }
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Recover password for: $name');
    return Future.delayed(loginTime).then((_) {
      if (name != 'user@example.com') {
        return 'User not found';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Welcome to the North',
      logo:  "assets/logo.jpg",

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
