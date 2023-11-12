import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController instanceAuth = Get.find();

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


}