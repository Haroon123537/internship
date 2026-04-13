import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCuNUJEabKO4A2FOXszposo0K81wGRgQzU',
    appId: '1:41697722346:web:dec2c6bcfcbc5fd3213c93',
    messagingSenderId: '41697722346',
    projectId: 'internship-2ac59',
    authDomain: 'internship-2ac59.firebaseapp.com',
    storageBucket: 'internship-2ac59.firebasestorage.app',
    measurementId: 'G-2ZKWNT6XP5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKN-7MLiiiJpljUG5rey6wKAwMuXTbXm0',
    appId: '1:41697722346:android:54e5c9659377704a213c93',
    messagingSenderId: '41697722346',
    projectId: 'internship-2ac59',
    storageBucket: 'internship-2ac59.firebasestorage.app',
  );
}