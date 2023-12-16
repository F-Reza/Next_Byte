import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/firebase_auth.dart';
import 'package:next_byte/controllers/video_controller.dart';
import 'package:next_byte/models/upload_video_model.dart';
import 'package:next_byte/utils/constants.dart';
import 'package:next_byte/views/home/for_you/item_video.dart';
import '../../comments/comment_screen.dart';
import 'circle_animation.dart';

class ForYouVideoScreen extends StatelessWidget {
  ForYouVideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 54,
            height: 54,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(27),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(27),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: 18,
          bottom: 0,
          child: Container(
            height: 28,
            width: 28,
            decoration: const BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            child: InkWell(
              onTap: () {
                print('----> Add Button Pressed.');
                //Get.to(() => const LoginScreen());
              },
                child: const Icon(Icons.add,),
            ),
          ),
        ),
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
          return PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              return Stack(
                children: [
                  ItemVideo(videoUrl: data.videoUrl.toString()),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  bottom: 10
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Wrap(
                                      children: [
                                        Text(
                                          data.userName.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          data.descriptionTags.toString(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.music_note,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 2,),
                                        Wrap(
                                          children: [
                                            Text(
                                              data.artistSongName.toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 3.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile(
                                    data.userProfileImage.toString(),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => videoController.likeVideo(data.videoID.toString()),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: data.likesList!.contains(AuthService.user!.uid)
                                              ? Colors.pink
                                              : Colors.white,
                                        ),
                                      ),
                                      Text(
                                        data.likesList!.length.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                              userID: data.videoID.toString(),
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.comment,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        data.totalComments.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        data.totalShares.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  CircleAnimation(
                                    child: buildMusicAlbum(data.userProfileImage.toString()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      ),
    );
  }
}
