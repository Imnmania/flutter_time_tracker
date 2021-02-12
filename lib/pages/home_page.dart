import 'dart:js';

import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth_provider.dart';
import 'package:time_tracker/widgets/platform_alert_dialog.dart';

class HomePage extends StatelessWidget {
  // final AuthBase auth;

  // const HomePage({
  //   Key key,
  //   @required this.auth,
  // }) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = AuthProvider.of(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Confirm',
      cancelActionText: 'Cancel',
    ).show(context);

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
