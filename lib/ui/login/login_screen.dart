import 'package:flutter/material.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/green_container_widhet.dart';
import 'package:geo_fresh/ui/common/login_container_text_widhet.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileNumberController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GreenContainerWidget(
                  child: LoginContainerTextWidget(
                    text: "Login",
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      TextFieldContainerWidget(
                        color: greyColor,
                        child: TextFormField(
                            autofocus: true,
                            maxLength: 10,
                            controller: mobileNumberController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                                prefix: Text(
                                  "+91",
                                  style: TextStyle(color: lightBlackColor),
                                ),
                                labelText: 'Mobile Number',
                                hintText: "Enter Mobile Number",
                                labelStyle: TextStyle(color: lightBlackColor))),
                      ),
                      SizedBox(height: 30),
                      ButtonWidget(
                        onPressed: () {
                          if (mobileNumberController.text != '' &&
                              mobileNumberController.text.length == 10) {
                            Navigator.of(context).pushNamed(
                                '/otp_verification_screen',
                                arguments: {
                                  "mobile":
                                      "+91" + mobileNumberController.text.trim()
                                });
                          } else {
                            showErrorToast(msg: "Wrong mobile number");
                          }
                        },
                        color: greenColor,
                        text: "Get OTP",
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
