import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AothService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? usuario;
  bool isloading = true;

  // ignore: non_constant_identifier_names
  Future<bool> SignInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await _auth.signInWithCredential(authCredential);
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  void signout() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
    Modular.to.pushReplacementNamed('/aoth');
  }
}
