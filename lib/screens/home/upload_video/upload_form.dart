import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/utils/constants.dart';
import 'package:next_byte/utils/helper_functions.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:video_player/video_player.dart';

import '../../../controller/upload_controller.dart';

class UploadForm extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const UploadForm({super.key, required this.videoFile, required this.videoPath});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  UploadController uploadVideoController = Get.put(UploadController());
  VideoPlayerController? videoPlayerController;
  final songArtistController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

    @override
  void initState() {
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });

    videoPlayerController!.initialize();
    videoPlayerController!.play();
    videoPlayerController!.pause();
    videoPlayerController!.setVolume(2);
    videoPlayerController!.setLooping(true);

    super.initState();
  }
  @override
  void dispose() {
    videoPlayerController!.dispose();
    songArtistController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.0,
                height: MediaQuery.of(context).size.height / 1.2,
                child: VideoPlayer(
                  videoPlayerController!,
                ),
              ),
              const SizedBox(height: 10,),
              showProgressBar == true ?
              Container(
                child: const SimpleCircularProgressBar(
                  progressColors: [
                    Colors.greenAccent,
                    Colors.blueAccent,
                    Colors.redAccent,
                    Colors.orangeAccent,
                  ],
                  animationDuration: 3,
                  backColor: Colors.white38,
                ),
              )
                  : Column(
                children: [
                  Container(
                    color: Colors.white30,
                    alignment: Alignment.centerLeft,
                    //decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      controller: songArtistController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Song Artist must not be empty!';
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.music_video_outlined,
                          color: Colors.white,
                        ),
                        hintText: 'Artist - Song',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    color: Colors.white30,
                    alignment: Alignment.centerLeft,
                    //decoration: kBoxDecorationStyle,
                    height: 60.0,
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Description must not be empty!';
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.video_collection_outlined,
                          color: Colors.white,
                        ),
                        hintText: 'Description - Tags',
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    width: double.infinity,
                    child: ElevatedButton (
                      onPressed: () {
                        print('Upload Button Pressed');
                        _saveVideoInfo();
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.all(15.0),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )
                      ),
                      child: const Text(
                        'Upload Now',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    width: double.infinity,
                    child: ElevatedButton (
                      onPressed: () {
                        print('Cancel Button Pressed');
                        Get.back();
                        //
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.all(15.0),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

    void _saveVideoInfo()  async{
      if(formKey.currentState!.validate()) {
        uploadVideoController.saveVideoInfo(
            songArtistController.text,
            descriptionController.text,
            widget.videoPath,
            context
        );
      }

      }


}
