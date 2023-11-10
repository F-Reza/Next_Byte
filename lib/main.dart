import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDRxg_xSDERMd2veMer4QySnAVnl212jYk",
            authDomain: "next-byte.firebaseapp.com",
            projectId: "next-byte",
            storageBucket: "next-byte.appspot.com",
            messagingSenderId: "634713349445",
            appId: "1:634713349445:web:a64fbf804da490d959722c",
            measurementId: "G-VMGDVZV379")
    );
  }else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Next_Byte',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
      /*initialRoute: SplashScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
      },*/
    );
  }
}

