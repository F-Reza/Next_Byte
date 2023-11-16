import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:next_byte/db/db_helper.dart';
import 'package:next_byte/models/user_model.dart';

class AuthController extends GetxController {
  static AuthController instanceAuth = Get.find();

  late Rx<File?> _pickedImage;
  File? get profileImage => _pickedImage.value;
  final ImageSource _imageSource = ImageSource.gallery;

  void getImageFromGallery() async {
    final selectedImage = await ImagePicker().pickImage(source: _imageSource);
    if(selectedImage != null){

      Get.snackbar(
          'Profile Photo',
          'Selected your profile photo'
      );
      _pickedImage = Rx<File?> (File(selectedImage.path));
      //_imagePath = selectedImage.path;
    }
  }
  void getImageFromCamera() async {
    final selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if(selectedImage != null){

      Get.snackbar(
          'Profile Photo',
          'Selected your profile photo'
      );
      _pickedImage = Rx<File?> (File(selectedImage.path));

    }
  }


  //Create Account For New User
  Future<void> addUser(UserModel userModel){
    return DbHelper.addUser(userModel);
  }

  Future<bool> doseUserExist(String uid) => DbHelper.doseUserExist(uid);


  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      DbHelper.getUserById(uid);

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
      DbHelper.updateProfile(uid, map);

  Future<String> updateImage(File file) async {
    final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child('ProfilePictures/$imageName');
    final task = photoRef.putFile(file);
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }



}