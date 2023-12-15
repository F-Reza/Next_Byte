
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/controllers/auth_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../../../auth/firebase_auth.dart';
import '../../../models/user_model.dart';


class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Size? size;
  var authController = AuthController.instanceAuth;

  final textController =TextEditingController();
  bool _progressBar = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Widget _buildLoadingBtn() {
    return const SimpleCircularProgressBar(
      progressColors: [
        Colors.greenAccent,
        Colors.blueAccent,
        Colors.redAccent,
        Colors.orangeAccent,
      ],
      animationDuration: 3,
      backColor: Colors.white38,
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      //drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: authController.getUserById(AuthService.user!.uid),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final userModel = UserModel.fromMap(snapshot.data!.data()!);
              return ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      Card(
                        color: Colors.white70,
                        elevation: 10,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: size!.width,
                              height: 240,
                              //decoration: const BoxDecoration(color: Colors.grey),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: userModel.image == null ?
                              Image.asset('images/male.png',
                                width: 200, height: 200, fit: BoxFit.cover,) :
                              Image.network(userModel.image!,
                                width: 200, height: 200, fit: BoxFit.cover,),
                            ),
                            if(_progressBar) Positioned(
                              right: 50,
                              left: 50,
                              child:  _buildLoadingBtn(),
                            ),
                          ],
                        ),
                      ),
                      //const SizedBox(height: 10,),
                      Card(
                        color: Colors.white,
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                ListTile(
                                    title: Text(userModel.email,style: const TextStyle(color: Colors.black),),
                                    trailing:
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Verified', style: TextStyle(color: Colors.green),),
                                        SizedBox(width: 5,),
                                        Icon(Icons.verified_user, color: Colors.green,),
                                      ],
                                    )
                                ),
                                ListTile(
                                  title: Text(userModel.name == null ||  userModel.name!.isEmpty ?
                                  'No display name added' : userModel.name!,
                                    style: userModel.name == null ||  userModel.name!.isEmpty ?
                                    const TextStyle(color: Colors.grey,fontSize: 14) :
                                    const TextStyle(color: Colors.black,),
                                  ),
                                ),
                                ListTile(
                                  title: Text(userModel.mobile == null ||  userModel.mobile!.isEmpty ?
                                  'No mobile number added' : 'Mobile: ${userModel.mobile!}',
                                    style: userModel.mobile == null ||  userModel.mobile!.isEmpty ?
                                    const TextStyle(color: Colors.grey,fontSize: 14) :
                                    const TextStyle(color: Colors.black,),
                                  ),
                                ),
                                ListTile(
                                  title: Text(userModel.dob == null ||  userModel.dob!.isEmpty ?
                                  'No Date of birth added' : 'Date of birth: ${userModel.dob!}',
                                    style: userModel.dob == null ||  userModel.dob!.isEmpty ?
                                    const TextStyle(color: Colors.grey,fontSize: 14) :
                                    const TextStyle(color: Colors.black,),
                                  ),
                                ),
                                ListTile(
                                  title: Text(userModel.gender == null ||  userModel.gender!.isEmpty ?
                                  'No gender added' : 'Gender: ${userModel.gender!}',
                                    style: userModel.gender == null ||  userModel.gender!.isEmpty ?
                                    const TextStyle(color: Colors.grey,fontSize: 14) :
                                    const TextStyle(color: Colors.black,),
                                  ),
                                ),
                                const SizedBox(height: 50,),
                                SizedBox(
                                  height: 36,
                                  child: Form(
                                    //key: _formKey,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.toNamed('/edit_profile');
                                      },
                                      child: const Text('Edit Profile'),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            if(snapshot.hasError) {
              return const Text('Failed to fetch Data');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }


}


