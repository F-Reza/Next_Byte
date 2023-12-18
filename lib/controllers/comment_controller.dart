import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:next_byte/utils/constants.dart';

import '../auth/firebase_auth.dart';
import '../models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _comments = Rx<List<CommentModel>>([]);
  List<CommentModel> get comments => _comments.value;

  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      firestore
          .collection('Videos')
          .doc(_postId)
          .collection('Comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<CommentModel> retValue = [];
          for (var element in query.docs) {
            retValue.add(CommentModel.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  postComment(String commentText) async {
    print('----> vID: $_postId');
    print('----> Cmt: $commentText');
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('Users')
            .doc(AuthService.user!.uid)
            .get();

        var allDocs = await firestore
            .collection('Videos')
            .doc(_postId)
            .collection('Comments')
            .get();
        int len = allDocs.docs.length;

        CommentModel comment = CommentModel(
          userName: (userDoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          userProfileImage: (userDoc.data()! as dynamic)['image'],
          uid: AuthService.user!.uid,
          id: 'Comment_$len',
        );
        print('---> Data: ${comment.toString()}');

        await firestore
            .collection('Videos')
            .doc(_postId)
            .collection('Comments')
            .doc('Comment_$len')
            .set(
              comment.toJson(),
            );
        DocumentSnapshot doc =
            await firestore.collection('Videos').doc(_postId).get();
        await firestore.collection('Videos').doc(_postId).update({
          'totalComments': (doc.data()! as dynamic)['totalComments'] + 1,
        });

        Get.snackbar(
          'Successfully',
          'you commented this video',
        );
      }
    } catch (e) {
      print('-----> Error $e');
      Get.snackbar(
        'Error While Commenting',
        e.toString(),
      );
    }
  }

  likeComment(String id) async {
    var uid = AuthService.user!.uid;
    DocumentSnapshot doc = await firestore
        .collection('Videos')
        .doc(_postId)
        .collection('Comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('Videos')
          .doc(_postId)
          .collection('Comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('Videos')
          .doc(_postId)
          .collection('Comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
