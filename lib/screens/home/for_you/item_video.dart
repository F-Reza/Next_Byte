
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ItemVideo extends StatefulWidget {
  final String title, url;
  const ItemVideo({super.key, required this.title, required this.url});

  @override
  State<ItemVideo> createState() => _ItemVideoState();
}

class _ItemVideoState extends State<ItemVideo> with SingleTickerProviderStateMixin{
  double width = 50;
  double height = 50;
  bool isExpanded = false;
  Color color = Colors.blue;
  double radius = 0;
  double degree = 0;
  late AnimationController controller;
  late Animation<double> turns;
  late Animation<double> deg;

  late VideoPlayerController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/videos/${widget.url}');
    _controller.addListener(() { });
    _controller.setLooping(true);
    _controller.initialize();
    _controller.play();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),);
    turns = CurvedAnimation(parent: controller, curve: Curves.linear);
    deg = Tween(begin: 0.0, end: 45.0).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic));
    //controller.forward();
    //controller.repeat(reverse: true);
    controller.repeat();
    controller.addListener(() {
      //setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayer(_controller),
        Positioned(
          left: 20, bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white),),
                const Text('Here is tha video description',
                    style: TextStyle(fontSize: 18,color: Colors.white70),),
              ],
            ),
        ),
        Positioned(
          right: 15, bottom: 30,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset('assets/images/user.png',width: 45, height: 45,),
                    Positioned(
                      left: 10,
                      bottom: -10,
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: const BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                        child: const Icon(Icons.add,),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                const ItemReact(icon: Icons.favorite, text: '28.5k'),
                const ItemReact(icon: Icons.comment, text: '30'),
                const ItemReact(icon: Icons.bookmark, text: '10'),
                const ItemReact(icon: Icons.shortcut, text: '30'),
                RotationTransition(
                  turns: turns,
                  child: const CircleAvatar(backgroundImage: AssetImage('assets/images/male.png',),),
                ),
              ],
            )),
      ],
    );
  }
}

class ItemReact extends StatelessWidget {
  final IconData icon;
  final String text;
  const ItemReact({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Icon(icon, size: 35, color: Colors.white),
          const SizedBox(height: 3,),
          Text(text, style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: Colors.white,fontSize: 16),),
        ],
      ),
    );
  }
}
