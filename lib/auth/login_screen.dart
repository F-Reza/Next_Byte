
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:next_byte/auth/firebase_auth.dart';
import 'package:next_byte/auth/signup_screen.dart';
import 'package:next_byte/controller/auth_controller.dart';
import 'package:next_byte/models/user_model.dart';
import 'package:next_byte/screens/launcher_screen.dart';
import 'package:next_byte/utils/constants.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var authController = AuthController.instanceAuth;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late Box box;

  @override
  void initState() {
    createBox();
    super.initState();
  }

  void createBox() async {
    box = await Hive.openBox('loginData');
    getLoginData();
  }

  void getLoginData() async {
    if(box.get('email') != null && box.get('password') != null) {
      emailController.text = box.get('email');
      passwordController.text = box.get('password');
      setState(() {
        _rememberMe = true;
      });
    }
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
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email must not be empty!';
              }else if (!value.contains('@')) {
                return 'Please Enter Valid Email';
              }
              else {
                return null;
              }
            },
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
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: passwordController,
            obscureText: isObscureText,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password must not be empty!';
              }
              if (value.length < 6) {
                return 'Password min 6 character';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(isObscureText
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton (
        onPressed: () {
          print('Forgot Password Button Pressed');
          Get.to(() => const SignupScreen());
        },
        //padding: const EdgeInsets.only(right: 0.0),
        child: const Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return SizedBox(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton (
        onPressed: () {
          print('Login Button Pressed');
          authenticate();
        },
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
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingBtn() {
    return const SimpleCircularProgressBar(
      progressColors: [
        Colors.greenAccent,
        Colors.blueAccent,
        Colors.redAccent,
        Colors.orangeAccent,
      ],
      animationDuration: 3,
      backColor: Colors.white38,
    );
  }

  Widget _buildSignInWithText() {
    return const Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function() onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Login with Facebook'),
            const AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
                () {
                  print('Login with Google');
                  AuthService.signInWithGoogle().then((credential) async {
                    if(credential.user != null) {
                      if(!await authController.doseUserExist(credential.user!.uid)) {

                        EasyLoading.show(status: 'Please Wait....',dismissOnTap: false);
                        final userModel = UserModel(
                            uid: AuthService.user!.uid,
                            image: AuthService.user!.photoURL,
                            name: credential.user!.displayName,
                            email: AuthService.user!.email!,
                            mobile: credential.user!.phoneNumber,
                            userCreationTime: Timestamp.fromDate(credential.user!.metadata.creationTime!),
                        );
                        await authController.addUser(userModel);
                        EasyLoading.dismiss();
                      }
                      Get.offAll(() => const LauncherScreen());
                    }
                  });
                },
            const AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        print('Sign Up Button Pressed');
        Get.off(const SignupScreen());
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
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
                    vertical: 120.0,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        _buildEmailTF(),
                        const SizedBox(height: 30.0,),
                        _buildPasswordTF(),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildSignInWithText(),
                        _buildSocialBtnRow(),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void authenticate()  async{
    if(formKey.currentState!.validate()) {
      if(_rememberMe) {
        box.put('email', emailController.text);
        box.put('password', passwordController.text);
      }
      if(!_rememberMe) {
        box.clear();
        box.delete('loginData');
      }
      EasyLoading.show(status: 'Please Wait....', dismissOnTap: false);
      try {
        final status = await AuthService.login(emailController.text, passwordController.text);
        if(status) {
          if(!mounted) return;
          EasyLoading.dismiss();
          Get.offAll(() => const LauncherScreen());
        }
      }on FirebaseAuthException catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orange[900],
            content: const Text(
              'Incorrect email or password.',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
        EasyLoading.dismiss();
        print('Error: ------> ${e.message!}');
      }
    }
  }

}



