import 'package:flutter/material.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class RadioButtonContainerWidget extends StatelessWidget {
  final String image;
  final String text;
  final Widget radioButtonWidget;
  final GestureTapCallback onTap;
  final Color containerColor;
  final Color textColor;
  double fontSize = 10.5.sp;
  FontWeight fontWeight = FontWeight.normal;

  RadioButtonContainerWidget(
      {Key key,
      this.image,
      this.containerColor,
      this.textColor,
      this.text,
      this.radioButtonWidget,
      this.fontSize,
      this.fontWeight,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46.0.w,
        width: 42.0.w,
        decoration: new BoxDecoration(
          color: containerColor,
          border: Border.all(color: greenColor, width: 0.0),
          borderRadius: new BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 3.0.h,
              ),
              Image.asset(
                image,
                height: 6.5.h,
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              radioButtonWidget,
            ],
          ),
        ),
      ),
    );
  }
}
