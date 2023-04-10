// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDI9q_23rXwJNN5aKzARg05EaC8H9OxiHU',
    appId: '1:268933439907:web:3b3d56fd14bba8a993ba16',
    messagingSenderId: '268933439907',
    projectId: 'chat-f322b',
    authDomain: 'chat-f322b.firebaseapp.com',
    storageBucket: 'chat-f322b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_XYJEf7h6dAsd9ZPFhUuzBNtTZ3Oa0lc',
    appId: '1:268933439907:android:eb42f9e546c8f5e293ba16',
    messagingSenderId: '268933439907',
    projectId: 'chat-f322b',
    storageBucket: 'chat-f322b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0uCETVxx65pR6KnEzL_0E86Z1hKjQCiM',
    appId: '1:268933439907:ios:04598d8fe222b78a93ba16',
    messagingSenderId: '268933439907',
    projectId: 'chat-f322b',
    storageBucket: 'chat-f322b.appspot.com',
    iosClientId: '268933439907-6u69imfbi7n6cf7vbosopqk9v8hjjgoq.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseLogin',
  );
}