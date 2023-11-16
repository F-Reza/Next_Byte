
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;

  //Login
  static Future<bool> login(String email, String password) async{
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return credential.user != null;
  }

  //Register
  static Future<bool> register(String email, String password) async{
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return credential.user != null;
  }


  //SignIn With Google
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  //LogOut
  static Future<void> logout() => _auth.signOut();


  //Update User Email
  static Future<void> updateEmail(String email) {
    return _auth.currentUser!.updateEmail(email);
  }

  //Update Display Name
  static Future<void> updateDisplayName(String name) =>
      _auth.currentUser!.updateDisplayName(name);

  //Update Photo URL
  static Future<void> updatePhotoUrl(String url) =>
      _auth.currentUser!.updatePhotoURL(url);



}