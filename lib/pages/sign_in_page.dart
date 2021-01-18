import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/custom_raised_button.dart';

class SignInPage extends StatelessWidget {
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
              btnName: 'Sign in with Google',
              textColor: Colors.blueGrey[700],
              btnColor: Colors.white,
              onPress: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomRaisedBtn(
              btnName: 'Sign in with Facebook',
              textColor: Colors.white,
              btnColor: Color(0xFF334D92),
              onPress: () {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomRaisedBtn(
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
            CustomRaisedBtn(
              btnName: 'Go Anonymous',
              textColor: Colors.black87,
              btnColor: Colors.lime[300],
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
