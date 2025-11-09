import 'package:cloud_firestore/cloud_firestore.dart';
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
    required String fullName,
    required String bloodType,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
            'uid': credential.user!.uid,
            'email': email,
            'fullName': fullName,
            'bloodType': bloodType,
          });

      await credential.user?.sendEmailVerification();
      showSnackBar(context, 'Sign Up Success! Please verify your email.');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VarificationEmail()),
      );
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        showSnackBar(context, 'Login Success!');
      } else {
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

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        final docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);
        final doc = await docRef.get();

        if (!doc.exists) {
          await docRef.set({
            'uid': user.uid,
            'email': user.email ?? '',
            'fullName': user.displayName ?? 'Unknown User',
            'bloodType': '',
          });
        }
      }

      showSnackBar(
        context,
        'Sign in successfully: ${user?.displayName ?? 'user'}',
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

      return userCredential;
    } catch (e) {
      showSnackBar(context, 'SignIn failed : $e');
      return null;
    }
  }

  static void showSnackBar(BuildContext context, String Message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(Message), backgroundColor: Color(0xFF16A34A)),
    );
  }
}
