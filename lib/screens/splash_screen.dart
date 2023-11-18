import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/screens/launcher_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Simulate a delay before navigating to the main screen
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the main screen
      //Get.off(() => const LauncherScreen());
      Get.offNamed('/auth');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/logo.png',height: 180, width: 150,),
            const Text('Next Byte', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),),
          ],
        ),
      ),
    );
  }
}