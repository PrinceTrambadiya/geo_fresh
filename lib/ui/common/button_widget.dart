import 'package:flutter/material.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String text;

  const ButtonWidget({Key key, this.onPressed, this.color, this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 46,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed,
        color: color,
        child: Text(
          text,
          style: TextStyle(fontSize: 12.5.sp, color: whiteColor),
        ),
      ),
    );
  }
}

class GreenBorderButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  double textSize = 10.0.sp;

  GreenBorderButtonWidget({Key key, this.onPressed, this.text, this.textSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          side:
              BorderSide(color: greenColor, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:
            Text(text, style: TextStyle(fontSize: textSize, color: greenColor)),
      ),
    );
  }
}

dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}
