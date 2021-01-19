import 'package:flutter/material.dart';
import 'package:time_tracker/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  void _updateUser(User user) {
    // print('User id: ${user.uid}');
    // print('Is anonymous: ${user.isAnonymous}');
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        // onSignIn: (user) => _updateUser(user),
        onSignIn: _updateUser,
      );
    }
    return Container(); // temporary placeholder for homepage
  }
}
