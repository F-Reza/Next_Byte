import 'package:flutter/material.dart';

class FollowingsVideoScreen extends StatefulWidget {
  const FollowingsVideoScreen({super.key});

  @override
  State<FollowingsVideoScreen> createState() => _FollowingsVideoScreenState();
}

class _FollowingsVideoScreenState extends State<FollowingsVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/da3.jpg'),
      ),
    );
  }
}
