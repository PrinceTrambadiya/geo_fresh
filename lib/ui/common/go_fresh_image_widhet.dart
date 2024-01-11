import 'package:flutter/material.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class GoFreshImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.0.h,
      width: 38.0.w,
      // height: 68,
      // width: 154,
      margin: EdgeInsets.only(top: 40, left: 40, right: 40),
      decoration: new BoxDecoration(
        color: whiteColor,
        border: Border.all(width: 0.0),
        borderRadius: new BorderRadius.all(Radius.elliptical(50, 50)),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/images/geo_fresh_image.png",
        ),
      ),
    );
  }
}
