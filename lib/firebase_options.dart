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
    apiKey: 'AIzaSyBoshQ-C5_yre6dQHMmcxkGZ9brifyENS8',
    appId: '1:124812759209:web:3ba4261724d3d6a415d9b8',
    messagingSenderId: '124812759209',
    projectId: 'passport-to-the-north-9262b',
    authDomain: 'passport-to-the-north-9262b.firebaseapp.com',
    storageBucket: 'passport-to-the-north-9262b.firebasestorage.app',
    measurementId: 'G-H1LTRC65PS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACFupN5mXlZ3VlzSexl3XJ-pF6KqfCmDM',
    appId: '1:124812759209:android:3e1a911a5fb9909515d9b8',
    messagingSenderId: '124812759209',
    projectId: 'passport-to-the-north-9262b',
    storageBucket: 'passport-to-the-north-9262b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChqB8NFfXnfaBkgGGpv0lnKuPtusqwMdE',
    appId: '1:124812759209:ios:88faaf0ff6f54efc15d9b8',
    messagingSenderId: '124812759209',
    projectId: 'passport-to-the-north-9262b',
    storageBucket: 'passport-to-the-north-9262b.firebasestorage.app',
    iosBundleId: 'com.example.passportToTheNorth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChqB8NFfXnfaBkgGGpv0lnKuPtusqwMdE',
    appId: '1:124812759209:ios:88faaf0ff6f54efc15d9b8',
    messagingSenderId: '124812759209',
    projectId: 'passport-to-the-north-9262b',
    storageBucket: 'passport-to-the-north-9262b.firebasestorage.app',
    iosBundleId: 'com.example.passportToTheNorth',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBoshQ-C5_yre6dQHMmcxkGZ9brifyENS8',
    appId: '1:124812759209:web:8e9cfc0d215a80e015d9b8',
    messagingSenderId: '124812759209',
    projectId: 'passport-to-the-north-9262b',
    authDomain: 'passport-to-the-north-9262b.firebaseapp.com',
    storageBucket: 'passport-to-the-north-9262b.firebasestorage.app',
    measurementId: 'G-NXFRBLR9LM',
  );
}
