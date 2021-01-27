import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Future<FBUser> currentUser();
  Future<FBUser> signInAnonymously();
  Future<FBUser> signInWithGoogle();
  Future<FBUser> signInWithFacebook();
  Future<FBUser> signInUserWithEmailAndPassword(String email, String password);
  Future<FBUser> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<FBUser> get onAuthStateChanged;
}

// This is user class
class FBUser {
  final String uid;

  FBUser({@required this.uid});
}

// This is Auth class
class Auth implements AuthBase {
  //
  final _firebaseAuth = FirebaseAuth.instance;
  //
  FBUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return FBUser(uid: user.uid);
  }

  @override
  Future<FBUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<FBUser> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<FBUser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<FBUser> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth.signInWithCredential(
        FacebookAuthProvider.credential(
          result.accessToken.token,
        ),
      );
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<FBUser> signInUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<FBUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    // for google
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    // for facebook
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    // for firebase user
    await _firebaseAuth.signOut();
  }

  // Stream Codes
  @override
  Stream<FBUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
}
