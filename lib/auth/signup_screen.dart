
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:next_byte/auth/login_screen.dart';
import 'package:next_byte/controller/auth_controller.dart';
import 'package:next_byte/utils/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  //var authController = AuthenticationController.instanceAuth;

  String? _dob;
  String? _genderGroupValue;
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildProfileImage() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15,),
          Card(
            elevation: 10,
            child: _imagePath == null ?
            Image.asset('assets/images/person.png',height: 160, width: 150,fit: BoxFit.cover,) :
            Image.file(File(_imagePath!),height: 160, width: 150,fit: BoxFit.cover,),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: (){
                    _imageSource = ImageSource.camera;
                    //authController.getImageFromGallery();
                    _getImage();
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera')),
              TextButton.icon(
                  onPressed: (){
                    _imageSource = ImageSource.gallery;
                    _getImage();
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text('Gallery')),
            ],
          ),
          const SizedBox(height: 15,),
        ],
      ),
    );
  }
  Widget _buildSelectGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Select Gender: ',style: kLabelStyle,),
        Radio<String>(
          value: 'Male',
          groupValue: _genderGroupValue,
          onChanged: (value) {
            setState(() {
              _genderGroupValue = value;
            });
          },
        ),
        const Text('Male'),
        Radio<String>(
          value: 'Female',
          groupValue: _genderGroupValue,
          onChanged: (value) {
            setState(() {
              _genderGroupValue = value;
            });
          },
        ),
        const Text('Female'),
      ],
    );
  }
  Widget _buildDOB() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: _selectDate,
            child: const Text('Select Date of Birth: ', style: TextStyle(fontSize: 16),)),
        Text(_dob == null ? 'No Date Selected' : _dob!)
      ],
    );
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Full Name',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle1,
          height: 60.0,
          child: TextField(
            controller: nameController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person_pin_outlined,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Email',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle1,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Mobile',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle1,
          height: 60.0,
          child: TextField(
            controller: mobileController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Enter your Mobile',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle1,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton (
        onPressed: () => print('Signup Button Pressed'),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white38,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(15.0),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )
        ),
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Color(0xFFE32C63),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () {
        print('Sign In Button Pressed');
        Get.to(const LoginScreen());
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEA2F71),
                      Color(0xFFEF215F),
                      Color(0xFFE0114F),
                      Color(0xFFEE114B),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Next Byte',style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      const SizedBox(height: 5,),
                      const Text(
                        'Create New Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildProfileImage(),
                      const SizedBox(height: 20.0),
                      _buildNameTF(),
                      const SizedBox(height: 10.0),
                      _buildEmailTF(),
                      const SizedBox(height: 10.0),
                      _buildMobileTF(),
                      const SizedBox(height: 10.0),
                      _buildPasswordTF(),
                      const SizedBox(height: 10.0),
                      _buildSelectGender(),
                      const SizedBox(height: 10.0),
                      _buildDOB(),
                      const SizedBox(height: 5.0),
                      _buildSignUpBtn(),
                      _buildSignInBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final selectedImage = await ImagePicker()
        .pickImage(source: _imageSource);
    if(selectedImage!=null){
      setState((){
        _imagePath = selectedImage.path;
      });
    }
  }


}



