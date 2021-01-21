import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FBUser {
  final String uid;

  FBUser({@required this.uid});
}

class Auth {
  //
  final _firebaseAuth = FirebaseAuth.instance;
  //
  FBUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return FBUser(uid: user.uid);
  }

  Future<FBUser> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  Future<FBUser> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
