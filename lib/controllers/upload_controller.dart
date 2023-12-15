
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:next_byte/views/home/home_screen.dart';
import 'package:video_compress/video_compress.dart';

import '../models/upload_video_model.dart';

class UploadController extends GetxController {

  compressVideoFile(String videoFile) async {
    final compressVideoFilePath = await VideoCompress.compressVideo(videoFile, quality: VideoQuality.MediumQuality);

    return compressVideoFilePath!.file;
  }

  getThumbnailImage(String videoFilePath) async {
    final thumbnailImage = await VideoCompress.getFileThumbnail(
        videoFilePath,
        quality: 50,
        position: -1,
    );
    return thumbnailImage;
  }


  uploadCompressVideoFile(String videoID, String videoFilePath) async {
    UploadTask videoUploadTask = FirebaseStorage.instance.ref()
        .child('All Videos').child(videoID)
        .putFile(await compressVideoFile(videoFilePath));
    TaskSnapshot snapshot = await videoUploadTask;
    String downloadUrlOfVideoUp = await snapshot.ref.getDownloadURL();
    return downloadUrlOfVideoUp;
  }

  uploadVideoThumbnailImage(String videoID, String videoFilePath) async {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
        .child('All Thumbnails').child(videoID)
        .putFile(await getThumbnailImage(videoFilePath));
    TaskSnapshot snapshot = await thumbnailUploadTask;
    String downloadUrlOfVideoThumbnail = await snapshot.ref.getDownloadURL();
    return downloadUrlOfVideoThumbnail;
  }


  saveVideoInfo(String artistSongName, String descriptionTags, String videoFilePath, BuildContext context) async{
    EasyLoading.show(status: 'Please Wait....', dismissOnTap: false);
    try{
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance.collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid).get();

      String videoID = DateTime.now().millisecondsSinceEpoch.toString();
      String videoDownloadUrl = await uploadCompressVideoFile(videoID, videoFilePath);
      String thumbnailDownloadUrl = await uploadVideoThumbnailImage(videoID, videoFilePath);

      VideoUploadModel videoObject = VideoUploadModel(
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>) ['name'],
        userProfileImage: (userDocumentSnapshot.data() as Map<String, dynamic>) ['image'],
        videoID: videoID,
        artistSongName: artistSongName,
        descriptionTags: descriptionTags,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        likesList: [],
        totalComments: 0,
        totalShares: 0,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );
      
      await FirebaseFirestore.instance.collection('Videos').doc(videoID).set(videoObject.toMap());

      EasyLoading.dismiss();
      Get.to(const HomeScreen());
      Get.offAllNamed('/home');
      Get.snackbar('New Video', 'you have successfully upload your new video');

    }catch(errorMsg){
      EasyLoading.dismiss();
      Get.snackbar('Upload failed!', 'Error occurred, your video is not upload. Try again...');
    }
  }


}