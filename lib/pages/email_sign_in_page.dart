import 'package:flutter/material.dart';
// import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/widgets/email_signIn_form.dart';

class EmailSignInPage extends StatelessWidget {
  //
  // final AuthBase auth;
  // const EmailSignInPage({@required this.auth});
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInForm(
                // auth: auth,
                ),
          ),
        ),
      ),
    );
  }
}
