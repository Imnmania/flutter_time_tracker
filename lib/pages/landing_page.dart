import 'package:flutter/material.dart';
import 'package:time_tracker/pages/home_page.dart';
import 'package:time_tracker/pages/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;
  LandingPage({@required this.auth});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FBUser>(
      stream: auth.onAuthStateChanged,
      // initialData: ,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FBUser user = snapshot.data;
          if (user == null) {
            return SignInPage(
              // onSignIn: (user) => _updateUser(user),
              // onSignIn: _updateUser,
              auth: auth,
            );
          }
          return HomePage(
            // onSignOut: () => _updateUser(null),
            auth: auth,
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // return HomePage(
        //   onSignOut: () => _updateUser(null),
        //   auth: widget.auth,
        // );
      },
    );
  }
}
