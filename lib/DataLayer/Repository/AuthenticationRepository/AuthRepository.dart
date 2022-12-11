import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  CollectionReference db = FirebaseFirestore.instance.collection('user');

  //create a function called signUp
  //send the email and password to createUserWithEmailAndPassword() function for sign up
  //the firebase will detect if this is a week password
  Future<void> signUp(
      {required String userEmail, required String userPassword}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        throw Exception('the password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        throw Exception('this account already exists for that email.');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }


  //sign in
  Future<void> signIn(
      {required String userEmail, required String userPassword }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> verifyEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }
}
