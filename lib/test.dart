import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

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
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),);
    turns = CurvedAnimation(parent: controller, curve: Curves.linear);
    deg = Tween(begin: 0.0, end: 45.0).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic));
    //controller.forward();
    //controller.repeat(reverse: true);
    controller.repeat();
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              curve: Curves.easeInOutCubic,
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              transform: Matrix4.rotationZ(degree.toRad()),
              duration: const Duration(milliseconds: 500),
              height: width,
              width: height,
              child: RotationTransition(
                  turns: turns,
                  child: Image.asset('assets/images/male.png',width: 80,),
              ),
            ),

            const SizedBox(height: 10,),
            TweenAnimationBuilder<TextStyle>(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutCubic,
                tween: TextStyleTween(
                  begin: const TextStyle(fontSize: 14, letterSpacing: 10,),
                  end: const TextStyle(fontSize: 20, letterSpacing: 1,),
                ),
                builder: (context, value, _)  => Text('Flutter is Fun!!!', style: value,),
            ),
          ],
        ),
      ),

    );
  }

}

extension on num {
  toRad() => this * 0.01745329;
}