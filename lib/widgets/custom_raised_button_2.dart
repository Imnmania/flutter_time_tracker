import 'package:flutter/material.dart';

class CustomRaisedBtn2 extends StatelessWidget {
  const CustomRaisedBtn2({
    Key key,
    @required this.btnName,
    @required this.textColor,
    @required this.btnColor,
    @required this.onPress,
  }) : super(key: key);

  final String btnName;
  final Color textColor;
  final Color btnColor;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.95,
      height: 50,
      child: RaisedButton(
        onPressed: onPress,
        child: Text(
          btnName,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
        color: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
