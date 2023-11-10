

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class DbHelper {
  static const String collectionUser = 'Users';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;


  //Add User
  static Future<void> addUser(UserModel userModel) =>
      _db.collection(collectionUser).doc(userModel.uid)
          .set(userModel.toMap());
  //Check User
  static Future<bool> doseUserExist(String uid) async {
    final snapshot = await _db.collection(collectionUser)
        .doc(uid).get();
    return snapshot.exists;
  }

  //Get User Data
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) =>
      _db.collection(collectionUser).doc(uid).snapshots();


  //Update Profile
  static Future<void> updateProfile(String uid, Map<String, dynamic> map) {
    return _db.collection(collectionUser).doc(uid).update(map);
  }








  }

