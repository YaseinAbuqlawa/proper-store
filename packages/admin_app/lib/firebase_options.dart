// Firebase options for the Admin dashboard.
// Shares the same Firebase project (proper-store-eg) as the main app.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'Admin dashboard is a web-only application.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBubU0hi2FzjRVLR6deBSfHkUayFr3WihM',
    appId: '1:968085072868:web:c8bf02111e2bcf385cf5f1',
    messagingSenderId: '968085072868',
    projectId: 'proper-store-eg',
    authDomain: 'theproperstore.com',
    storageBucket: 'proper-store-eg.firebasestorage.app',
    measurementId: 'G-S4X9PGLK2Q',
  );
}
