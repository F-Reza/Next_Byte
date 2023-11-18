
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/login_screen.dart';
import 'package:next_byte/screens/home_screen.dart';
import '../auth/firebase_auth.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero,() {
      if(AuthService.user==null){
        Get.offAll(() => const LoginScreen());
      }else {
        Get.offAll(() => const HomeScreen());

        print('Login Successfully!');
        Fluttertoast.showToast(
          msg: 'Login Successfully!',
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,);
    }
  });
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
