import 'package:flutter/material.dart';
import 'package:time_tracker/pages/home_page.dart';
import 'package:time_tracker/pages/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;
  LandingPage({@required this.auth});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FBUser _user;

  void _updateUser(FBUser user) {
    // print('User id: ${user.uid}');
    // print('Is anonymous: ${user.isAnonymous}');
    setState(() {
      _user = user;
    });
  }

  void _checkCurrentUser() async {
    FBUser user = await widget.auth.currentUser();
    _updateUser(user);
  }

  @override
  void initState() {
    super.initState();
    // the below line also works. but we separate the funcion for readability
    // User user = FirebaseAuth.instance.currentUser;
    // _updateUser(user);
    //
    _checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        // onSignIn: (user) => _updateUser(user),
        onSignIn: _updateUser,
        auth: widget.auth,
      );
    }
    return HomePage(
      onSignOut: () => _updateUser(null),
      auth: widget.auth,
    ); // temporary placeholder for homepage
  }
}
