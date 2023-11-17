import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:next_byte/db/db_helper.dart';
import 'package:next_byte/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<String> updateImage(XFile xFile) async {
    final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child('Profile Pictures/$imageName');
    final task = photoRef.putFile(File(xFile.path));
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }




  Future<void> callContact(String number) async {
    final uri = Uri.parse('tel:$number');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch call app';
    }
  }

  Future<void> messageContact(String number) async {
    final uri = Uri.parse('sms:$number');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch message app';
    }
  }

  Future<void> mailContact(String mail) async {
    final uri = Uri.parse('mailTo:$mail');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch mail app';
    }
  }

  Future<void> webContact(String web) async {
    final uri = Uri.parse('https:$web');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch browser';
    }
  }

  Future<void> locateContact(String address) async {
    String urlString = '';
    if (Platform.isAndroid) {
      urlString = 'geo:00?q=$address';
    } else if (Platform.isIOS) {
      urlString = 'https://maps.apple.com/q=$address';
    }

    final uri = Uri.parse(urlString);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Cannot launch map';
    }
  }



  /*Future<String> updateImage(File file) async {
    final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child('Profile Pictures/$imageName');
    final task = photoRef.putFile(file);
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }*/

}