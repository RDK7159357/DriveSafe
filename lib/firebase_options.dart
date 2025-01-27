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
    apiKey: 'AIzaSyCxKr3hafDgdTHpa9fTRRTuR9cH7bQZSQc',
    appId: '1:25435559338:web:0f2305b7944c17ed34c7d3',
    messagingSenderId: '25435559338',
    projectId: 'drive-safe-425e6',
    authDomain: 'drive-safe-425e6.firebaseapp.com',
    storageBucket: 'drive-safe-425e6.firebasestorage.app',
    measurementId: 'G-VWMBPMLWJE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhuz6Bu-JXe1ND4qt-SOFV0FeH8esSico',
    appId: '1:25435559338:android:47cd18608e7a362d34c7d3',
    messagingSenderId: '25435559338',
    projectId: 'drive-safe-425e6',
    storageBucket: 'drive-safe-425e6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCv_SSLXhGK6q45uUb7-UkgIATWH-F0-mQ',
    appId: '1:25435559338:ios:fa0f13208a8d175f34c7d3',
    messagingSenderId: '25435559338',
    projectId: 'drive-safe-425e6',
    storageBucket: 'drive-safe-425e6.firebasestorage.app',
    iosBundleId: 'com.example.driveSafe',
  );

}