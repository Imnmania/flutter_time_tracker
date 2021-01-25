import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthBase {
  Future<FBUser> currentUser();
  Future<FBUser> signInAnonymously();
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
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Stream Codes
  @override
  Stream<FBUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }
}
