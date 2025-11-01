
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mus3if/screens/home_screen.dart';
import 'package:mus3if/screens/varification_email.dart';

class FirebaseAuthFunction {
  static Future<void> SignUpWithPasswordAndEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VarificationEmail()),
      );
      await credential.user?.sendEmailVerification();
      showSnackBar(context, 'Sign Up Success! Please verify your email.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<void> LoginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null && credential.user!.emailVerified) {
        // مسموح يدخل
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        showSnackBar(context, 'Login Success!');
      } else {
        // مش متفعل
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VarificationEmail()),
        );
        await credential.user?.sendEmailVerification();
        showSnackBar(context, 'Please verify your email first.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Invalid email or password.');
      } else {
        showSnackBar(context, e.message ?? 'Authentication failed: ${e.code}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      FirebaseAuthFunction.showSnackBar(
        context,
        'Password reset link sent! Check your Email',
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'invalid-credential') {
        showSnackBar(context, 'Invalid email or password.');
      } else {
        showSnackBar(context, e.message ?? 'Authentication failed: ${e.code}');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<UserCredential?> signInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        showSnackBar(context, 'SignIn Canceled');
        return null;
      }
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final UserCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      showSnackBar(
        context,
        'Sign in successfully: ${UserCredential.user?.displayName ?? 'user'}',
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      return UserCredential;
    } catch (e) {
      showSnackBar(context, 'SignIn failed : $e');
      return null;
    }
  }



  static void showSnackBar(BuildContext context, String Message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(Message)));
  }
}
