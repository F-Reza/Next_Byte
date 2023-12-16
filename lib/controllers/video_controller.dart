import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:next_byte/models/upload_video_model.dart';
import 'package:next_byte/utils/constants.dart';

import '../auth/firebase_auth.dart';
import '../db/db_helper.dart';


class VideoController extends GetxController {
  final Rx<List<VideoUploadModel>> _videoList = Rx<List<VideoUploadModel>>([]);

  List<VideoUploadModel> get videoList => _videoList.value;
  List<VideoUploadModel> alVideoList = [];

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
        firestore.collection('Videos').snapshots().map((QuerySnapshot query) {
      List<VideoUploadModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          VideoUploadModel.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  likeVideo(String videoID) async {
    DocumentSnapshot doc = await firestore.collection('Videos').doc(videoID).get();
    var userID = AuthService.user!.uid;
    if ((doc.data()! as dynamic)['likesList'].contains(userID)) {
      await firestore.collection('Videos').doc(videoID).update({
        'likesList': FieldValue.arrayRemove([userID]),
      });
    } else {
      await firestore.collection('Videos').doc(videoID).update({
        'likesList': FieldValue.arrayUnion([userID]),
      });
    }
  }





  getAllProducts() {
    DbHelper.getAllVideos().listen((snapshot) {
      alVideoList = List.generate(snapshot.docs.length, (index) =>
          VideoUploadModel.fromMap(snapshot.docs[index].data()));
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductById(String id) =>
      DbHelper.getVideoById(id);


}
