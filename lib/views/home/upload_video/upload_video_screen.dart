
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'upload_form.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 10,
              color: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: ElevatedButton(
                        onPressed: () {
                          getVideoFile(ImageSource.gallery);
                        },
                        style:ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical:4),
                            elevation: 1,
                            //primary: Colors.white12, // background
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.photo_library_rounded,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Gallery',style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: ElevatedButton(
                        onPressed: () {
                          getVideoFile(ImageSource.camera);
                        },
                        style:ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical:4),
                            elevation: 1,
                            //primary: Colors.black54, // background
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.photo_camera_rounded,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Camera',style: TextStyle(fontSize: 20),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getVideoFile(ImageSource imageSource) async {
    final videoFile = await ImagePicker().pickVideo(source: imageSource);
    if(videoFile != null) {
      Get.to(UploadForm(
        videoFile: File(videoFile.path),
        videoPath: videoFile.path,),
      );
    }
  }


}
