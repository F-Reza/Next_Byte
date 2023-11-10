
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? image;
  String name;
  String email;
  String mobile;
  String password;
  String dob;
  String gender;
  String? facebook;
  String? instagram;
  String? youtube;
  Timestamp userCreationTime;
  String? deviceToken;

  UserModel(
      {required this.uid,
      this.image,
      required this.name,
      required this.email,
      required this.mobile,
      required this.password,
      required this.dob,
      required this.gender,
      this.facebook,
      this.instagram,
      this.youtube,
      required this.userCreationTime,
      this.deviceToken});

  Map<String, dynamic> toMap() {
   return <String, dynamic> {
    'uid' : uid,
    'image' : image,
    'name' : name,
    'email' : email,
    'mobile' : mobile,
    'password' : password,
    'dob' : dob,
    'gender' : gender,
    'facebook' : facebook,
    'instagram' : instagram,
    'youtube' : youtube,
    'deviceToken' : deviceToken,
    'userCreationTime' : userCreationTime,
   };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
   uid: map['uid'],
   image: map['image'],
   name: map['name'],
   email: map['email'],
   mobile: map['mobile'],
   password: map['password'],
   dob: map['dob'],
   gender: map['gender'],
   facebook: map['facebook'],
   instagram: map['instagram'],
   youtube: map['youtube'],
   deviceToken: map['deviceToken'],
   userCreationTime: map['userCreationTime'],
  );




}