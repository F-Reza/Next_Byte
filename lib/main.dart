import 'package:flutter/material.dart';
import 'package:next_byte/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Next_Byte',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
      //initialRoute: LoginScreen.routeName,
      // routes: {
      //   LoginScreen.routeName: (context) => const LoginScreen(),
      // },
    );
  }
}

