import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/firebase_auth.dart';

import '../following/followings_video_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';
import '../upload_video/custom_add_icon.dart';
import '../upload_video/upload_video_screen.dart';
import 'for_you/for_you_video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int screenIndex = 0;
  List screenList = [
    ForYouVideoScreen(),
    const SearchScreen(),
    const UploadVideoScreen(),
    const FollowingsVideoScreen(),
    const ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30,),
            label: 'Discover',
          ),

          BottomNavigationBarItem(
            icon: CustomAddIcon(),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_sharp, size: 30,),
            label: 'Following',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30,),
            label: 'Me',
          ),
        ],
      ),
      body: screenList[screenIndex],
    );
  }
}
