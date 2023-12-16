import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String userName;
  String comment;
  final datePublished;
  List likes;
  String userProfileImage;
  String uid;
  String id;

  CommentModel({
    required this.userName,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.userProfileImage,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'userProfileImage': userProfileImage,
        'uid': uid,
        'id': id,
      };

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
      userName: snapshot['userName'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      userProfileImage: snapshot['userProfileImage'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
