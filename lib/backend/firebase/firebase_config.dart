import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAme5Sp9FptdAfELbyKwVrZNYuTiV3_3sk",
            authDomain: "affirmation-lguktd.firebaseapp.com",
            projectId: "affirmation-lguktd",
            storageBucket: "affirmation-lguktd.firebasestorage.app",
            messagingSenderId: "446630269981",
            appId: "1:446630269981:web:b9e54edfc4ec67b49f62f4"));
  } else {
    await Firebase.initializeApp();
  }
}
