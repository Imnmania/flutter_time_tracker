import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

import 'package:time_tracker/widgets/custom_raised_button.dart';
import 'package:time_tracker/widgets/custom_raised_button_2.dart';

class SignInPage extends StatelessWidget {
  //
  final AuthBase auth;
  const SignInPage({
    Key key,
    @required this.auth,
  });

  // Future<void> _signInAnonumously() async {
  //   try {
  //     final authResult = await FirebaseAuth.instance.signInAnonymously();
  //     // print('${authResult.user.uid}');
  //     // print('${authResult.user.isAnonymous}');
  //     onSignIn(authResult.user);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Future<void> _signInAnonumously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomRaisedBtn(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/google-logo.png'),
                  Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  Opacity(
                      opacity: 0.0,
                      child: Image.asset('assets/images/google-logo.png')),
                ],
              ),
              btnColor: Colors.white,
              onPress: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomRaisedBtn(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/facebook-logo.png'),
                  Text(
                    'Sign in with Facebook',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Opacity(
                      opacity: 0.0,
                      child: Image.asset('assets/images/facebook-logo.png')),
                ],
              ),
              btnColor: Color(0xFF334D92),
              onPress: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomRaisedBtn2(
              btnName: 'Sign in with Email',
              textColor: Colors.white,
              btnColor: Colors.teal[700],
              onPress: () {},
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'or',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            CustomRaisedBtn2(
              btnName: 'Go Anonymous',
              textColor: Colors.black87,
              btnColor: Colors.lime[300],
              onPress: _signInAnonumously,
            ),
            // Image.asset('assets/images/google-logo.png'),
          ],
        ),
      ),
    );
  }
}
