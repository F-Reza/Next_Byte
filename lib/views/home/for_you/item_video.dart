
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ItemVideo extends StatefulWidget {
  final String videoUrl;
  const ItemVideo({super.key, required this.videoUrl});

  @override
  State<ItemVideo> createState() => _ItemVideoState();
}

class _ItemVideoState extends State<ItemVideo>{

  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((value) {
      _controller.setVolume(2);
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.white70,
      ),
      child: VideoPlayer(_controller),
    );
  }
}

