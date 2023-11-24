import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  double width = 100;
  double height = 100;
  bool isExpanded = false;
  Color color = Colors.blue;
  double radius = 0;
  double degree = 0;
  late AnimationController controller;
  late Animation<double> turns;
  late Animation<double> deg;


  @override
  void initState() {
    super.initState();

    // Simulate a delay before navigating to the main screen
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the main screen
      //Get.off(() => const LauncherScreen());
      Get.offNamed('/auth');
    });


    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    turns = CurvedAnimation(parent: controller, curve: Curves.linear);
    deg = Tween(begin: 0.0, end: 45.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
    );

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
            //const Text('Next Byte', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),),
            TweenAnimationBuilder<TextStyle>(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOutCubic,
              tween: TextStyleTween(
                begin: const TextStyle(fontSize: 34, letterSpacing: 10,),
                end: const TextStyle(fontSize: 26, letterSpacing: 1,),
              ),
              builder: (context, value, _)  => Text('Next Byte', style: value,),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Next Digit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
      ),
    );
  }
}

extension on num {
  toRad() => this * 0.01745329;
}