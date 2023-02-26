import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyB0g9jBjcrRKOpj22ojk6qswolBZL9E2Rg",
            authDomain: "practicaexamen-ec81d.firebaseapp.com",
            projectId: "practicaexamen-ec81d",
            storageBucket: "practicaexamen-ec81d.appspot.com",
            messagingSenderId: "618946772861",
            appId: "1:618946772861:web:f0652ab24f677622be9614",
            measurementId: "G-QMMG9ECVNL"));
  } else {
    await Firebase.initializeApp();
  }
}
