import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/firebase_auth.dart';
import 'package:next_byte/utils/constants.dart';


class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
    print('---->>ID: $_uid');
  }

  getUserData() async {
    List<String> thumbnails = [];
    var myVideos = await firestore
        .collection('Videos')
        .where('userID', isEqualTo: _uid.value)
        .get();
    print('---> Videos Data: ${myVideos.docs}');
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnailUrl']);
      print('---> Data: ${myVideos.docs.length}');
    }

    DocumentSnapshot userDoc =
        await firestore.collection('Users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String image = userData['image'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data()['likesList'] as List).length;
    }
    var followerDoc = await firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Followers')
        .get();
    var followingDoc = await firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Following')
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Followers')
        .doc(AuthService.user!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'Followers': followers.toString(),
      'Following': following.toString(),
      'isFollowing': isFollowing,
      'likesList': likes.toString(),
      'image': image,
      'name': name,
      'thumbnailUrl': thumbnails,
    };
    update();
  }

  followUser() async {
    var doc = await firestore
        .collection('Users')
        .doc(_uid.value)
        .collection('Followers')
        .doc(AuthService.user!.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection('Users')
          .doc(_uid.value)
          .collection('Followers')
          .doc(AuthService.user!.uid)
          .set({});
      await firestore
          .collection('Users')
          .doc(AuthService.user!.uid)
          .collection('Following')
          .doc(_uid.value)
          .set({});
      _user.value.update(
        'Followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    } else {
      await firestore
          .collection('Users')
          .doc(_uid.value)
          .collection('Followers')
          .doc(AuthService.user!.uid)
          .delete();
      await firestore
          .collection('Users')
          .doc(AuthService.user!.uid)
          .collection('Following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'Followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
