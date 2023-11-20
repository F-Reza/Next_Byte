import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/firebase_auth.dart';

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
                    //Get.to(() => const ProfileScreen());
                    Get.toNamed('/profile');
                  },
                  child: const Text('Profile'),
                ),
                PopupMenuItem(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    await Future.delayed(Duration.zero);
                    //Get.to(() => const HomeScreen());
                    Get.offAllNamed('/Settings');
                  },
                  child: const Text('Settings'),
                ),
                PopupMenuItem(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    await Future.delayed(Duration.zero);

                    AuthService.logout().then((value) =>
                        Get.offAllNamed('/auth'),
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
