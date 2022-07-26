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
    apiKey: 'AIzaSyApdaaCgtxSJCsIH-9OQ9jW7vUvgQH8CZY',
    appId: '1:1088512247669:web:0d62d5ac16787cfa37b53c',
    messagingSenderId: '1088512247669',
    projectId: 'firebasse-baruu',
    authDomain: 'firebasse-baruu.firebaseapp.com',
    storageBucket: 'firebasse-baruu.appspot.com',
    measurementId: 'G-B690YM0Z8C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCABySaWzbmYDBRXF1LwI2Ze4q6OrRwbtY',
    appId: '1:1088512247669:android:78d470d49019804537b53c',
    messagingSenderId: '1088512247669',
    projectId: 'firebasse-baruu',
    storageBucket: 'firebasse-baruu.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDhgSSMK2D_1WWFf6F9F-g1mg7839gJDI',
    appId: '1:1088512247669:ios:005351461d31651037b53c',
    messagingSenderId: '1088512247669',
    projectId: 'firebasse-baruu',
    storageBucket: 'firebasse-baruu.appspot.com',
    iosClientId: '1088512247669-8o4gm5h9gv6vlddd29f86elh3n0k7t19.apps.googleusercontent.com',
    iosBundleId: 'com.example.sewarumah',
  );
}
