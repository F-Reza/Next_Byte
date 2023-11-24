
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:next_byte/auth/launcher_screen.dart';
import 'package:next_byte/auth/login_screen.dart';
import 'package:next_byte/auth/signup_screen.dart';
import 'package:next_byte/controller/auth_controller.dart';
import 'package:next_byte/screens/home/home_screen.dart';
import 'package:next_byte/screens/home/profile/edit_profile_screen.dart';
import 'package:next_byte/screens/home/profile/profile_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:next_byte/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
  });
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Next_Byte',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey,
      ),
      builder: EasyLoading.init(),
      //home: const SplashScreen(),
      unknownRoute: GetPage(name: '/404', page: () => const SplashScreen()),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/',
          page: () => const SplashScreen(),
          transition: Transition.zoom,
        ),
        GetPage(name: '/auth',
            page: () => const LauncherScreen(),
            transition: Transition.zoom,
        ),
        GetPage(name: '/login',
            page: () => const LoginScreen(),
            transition: Transition.zoom,
        ),
        GetPage(name: '/signup',
            page: () => const SignupScreen(),
            transition: Transition.zoom,
        ),
        GetPage(name: '/home',
            page: () => const HomeScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(name: '/profile',
          page: () => const ProfileScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(name: '/edit_profile',
          page: () => const EditProfileScreen(),
          transition: Transition.rightToLeft,
        ),
      ],
    );
  }
}

