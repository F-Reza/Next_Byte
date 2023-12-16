import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/firebase_auth.dart';
import 'package:next_byte/controllers/comment_controller.dart';
import 'package:next_byte/utils/constants.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String videoID;
  CommentScreen({
    Key? key,
    required this.videoID,
  }) : super(key: key);

  final _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(videoID);

    return Scaffold(
      backgroundColor: Colors.white24,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return Card(
                          elevation: 1,
                          color: Colors.white24,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.lightGreen,
                              backgroundImage: NetworkImage(comment.userProfileImage),
                            ),
                            title: Row(
                              children: [
                                Wrap(
                                  children: [
                                    Text(
                                      '${comment.userName}: ',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      comment.comment,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        //fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  tago.format(
                                    comment.datePublished.toDate(),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${comment.likes.length} likes',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () =>
                                  commentController.likeComment(comment.id),
                              child: Icon(
                                Icons.favorite,
                                size: 25,
                                color: comment.likes
                                        .contains(AuthService.user!.uid)
                                    ? Colors.blueAccent
                                    : Colors.white,
                              ),
                            ),
                          ),
                        );
                      });
                }),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () =>
                      commentController.postComment(_commentController.text),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
