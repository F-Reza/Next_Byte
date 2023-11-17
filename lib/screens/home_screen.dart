import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/firebase_auth.dart';
import 'package:next_byte/screens/launcher_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Home'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    await Future.delayed(Duration.zero);
                    Get.to(const HomeScreen());
                  },
                  child: const Text('Home'),
                ),
                PopupMenuItem(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    await Future.delayed(Duration.zero);

                    AuthService.logout().then((value) =>
                      Get.to(const LauncherScreen()),
                    );
                  },
                  child: const Text('Logout'),
                ),
              ]
          ),
        ],
      ),
    );
  }
}
