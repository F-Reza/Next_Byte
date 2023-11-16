

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../db/db_helper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;


  Future<void> addUser(UserModel userModel){
    return DbHelper.addUser(userModel);
  }

  Future<bool> doseUserExist(String uid) => DbHelper.doseUserExist(uid);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      DbHelper.getUserById(uid);

  Future<void> updateProfile(String uid, Map<String, dynamic> map) =>
        DbHelper.updateProfile(uid, map);

  Future<String> updateImage(File file) async {
    final imageName = 'Image_${DateTime.now().millisecondsSinceEpoch}';
    final photoRef = FirebaseStorage.instance.ref().child('Profile Pictures/$imageName');
    final task = photoRef.putFile(file);
    final snapshot = await task.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }


}

