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
    apiKey: 'AIzaSyC1ZTqFyjQqwHDKTFCul_CYvTok11oiv_A',
    appId: '1:213087588930:web:fcc50514b8fd191009d3db',
    messagingSenderId: '213087588930',
    projectId: 'medicinelocator-67a29',
    authDomain: 'medicinelocator-67a29.firebaseapp.com',
    storageBucket: 'medicinelocator-67a29.appspot.com',
    measurementId: 'G-47CPK8VM87',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApWNim0nnuvHJQWu5D9AhCUeIWmXYWSDc',
    appId: '1:213087588930:android:5cc04139a14bcdb509d3db',
    messagingSenderId: '213087588930',
    projectId: 'medicinelocator-67a29',
    storageBucket: 'medicinelocator-67a29.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpiIASl_sUw9iYAm3ylZPPK6vHuAhcn4E',
    appId: '1:213087588930:ios:8cd3cb881707403f09d3db',
    messagingSenderId: '213087588930',
    projectId: 'medicinelocator-67a29',
    storageBucket: 'medicinelocator-67a29.appspot.com',
    iosBundleId: 'com.example.medicinelocator1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpiIASl_sUw9iYAm3ylZPPK6vHuAhcn4E',
    appId: '1:213087588930:ios:8cd3cb881707403f09d3db',
    messagingSenderId: '213087588930',
    projectId: 'medicinelocator-67a29',
    storageBucket: 'medicinelocator-67a29.appspot.com',
    iosBundleId: 'com.example.medicinelocator1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC1ZTqFyjQqwHDKTFCul_CYvTok11oiv_A',
    appId: '1:213087588930:web:2b7d55d8e88236b209d3db',
    messagingSenderId: '213087588930',
    projectId: 'medicinelocator-67a29',
    authDomain: 'medicinelocator-67a29.firebaseapp.com',
    storageBucket: 'medicinelocator-67a29.appspot.com',
    measurementId: 'G-26WXC1367F',
  );
}
