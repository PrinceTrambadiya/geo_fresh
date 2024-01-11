import 'package:flutter/material.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class LoginContainerTextWidget extends StatelessWidget {
  final String text;

  const LoginContainerTextWidget({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8.0.h,
        ),
        InkWell(
          onTap: () async {
            await UserRepository().deleteAllSecureValue();
            Navigator.pushNamedAndRemoveUntil(
                context, "/login_screen", (r) => false);
          },
          child: Text(
            "Welcome",
            style: TextStyle(
                fontSize: 40.0.sp,
                color: whiteColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        /*SizedBox(
          height: 6.0.h,
        ),
        Text(
          "Lorem Ipsum is simply dummy \ntext of the printing and typesetting industry.",
          style: TextStyle(fontSize: 10.0.sp, color: whiteColor),
          textAlign: TextAlign.center,
        ),*/
        SizedBox(
          height: 6.0.h,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 20.0.sp, color: whiteColor),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
