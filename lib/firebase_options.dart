// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAxckMPAi10vlXI_8_t7J8aixzkKkviQDo',
    appId: '1:324508338106:web:f353ffdf02530a3cc93f83',
    messagingSenderId: '324508338106',
    projectId: 'passport-to-the-north-95784',
    authDomain: 'passport-to-the-north-95784.firebaseapp.com',
    storageBucket: 'passport-to-the-north-95784.firebasestorage.app',
    measurementId: 'G-K5FNR3W09Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBScVrFBsHj2zpBt80r52IZPLV1wZ4zlJ0',
    appId: '1:324508338106:android:5b03aa988e2039c2c93f83',
    messagingSenderId: '324508338106',
    projectId: 'passport-to-the-north-95784',
    storageBucket: 'passport-to-the-north-95784.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQ7sTW3SYi5DB7VGWtj98KXcJNO1B7dcg',
    appId: '1:324508338106:ios:5f73cef472323679c93f83',
    messagingSenderId: '324508338106',
    projectId: 'passport-to-the-north-95784',
    storageBucket: 'passport-to-the-north-95784.firebasestorage.app',
    iosBundleId: 'com.example.passportToTheNorth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQ7sTW3SYi5DB7VGWtj98KXcJNO1B7dcg',
    appId: '1:324508338106:ios:5f73cef472323679c93f83',
    messagingSenderId: '324508338106',
    projectId: 'passport-to-the-north-95784',
    storageBucket: 'passport-to-the-north-95784.firebasestorage.app',
    iosBundleId: 'com.example.passportToTheNorth',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAxckMPAi10vlXI_8_t7J8aixzkKkviQDo',
    appId: '1:324508338106:web:7570d02ea4f74334c93f83',
    messagingSenderId: '324508338106',
    projectId: 'passport-to-the-north-95784',
    authDomain: 'passport-to-the-north-95784.firebaseapp.com',
    storageBucket: 'passport-to-the-north-95784.firebasestorage.app',
    measurementId: 'G-5HXHZLGKQP',
  );

}