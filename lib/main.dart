import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/HomePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCnehkyh3SYzDaW-noAOt_yt-3zmUAVtcs",
            authDomain: "crud-8579b.firebaseapp.com",
            projectId: "crud-8579b",
            storageBucket: "crud-8579b.appspot.com",
            messagingSenderId: "710729870549",
            appId: "1:710729870549:web:21a742b3ab77731492065c",
            measurementId: "G-ZTQ5H0SF6Z"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
