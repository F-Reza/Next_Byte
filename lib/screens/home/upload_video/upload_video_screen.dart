import 'package:flutter/material.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_sharp,color: Colors.blueGrey,size: 100,),
            ElevatedButton(
              onPressed: () {
                //
              },
              style:ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical:8),
                elevation: 1,
                primary: Colors.deepPurpleAccent, // background
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
              ),
                child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
