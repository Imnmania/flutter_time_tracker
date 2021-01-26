import 'package:flutter/material.dart';

class CustomSignInButton extends StatelessWidget {
  const CustomSignInButton({
    @required this.text,
    @required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        onPressed: onPressed,
        color: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
