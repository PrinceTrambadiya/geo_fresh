import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/login_bloc/login_bloc.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/green_container_widhet.dart';
import 'package:geo_fresh/ui/common/login_container_text_widhet.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';

class OTPVerificationScreen extends StatefulWidget {
  final argument;

  const OTPVerificationScreen({Key key, this.argument}) : super(key: key);
  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController otpController = new TextEditingController();
  String mobile = '';
  Timer _timer;
  bool isTimer = false;
  String verificationCodeId = '';
  bool isLoading = true;
  int _time = 30;
  bool isError;
  String enteredOtp = '';

  BoxDecoration pinPutDecoration = BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey[500]));
  BoxDecoration selectedDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: greenColor));
  @override
  void initState() {
    // TODO: implement initState
    mobile = widget.argument['mobile'];
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          return LoginBloc()..add(InitialLoginEvent());
        },
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is LoginInitial) {
              registerUser(context);
            } else if (state is LoginInWithMobileSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/role_selection_screen", (r) => false);
            } else if (state is UserNotVerified) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/dashboard", (r) => false,
                  arguments: {"userVerified": false});
            } else if (state is UserRegistered) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/dashboard", (r) => false,
                  arguments: {"userVerified": true});
            } else if (state is UserNotRegistered) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/role_selection_screen", (r) => false);
            } else if (state is LoginFailureState) {
              debugPrint("ERROR1:- ${state.error}");
              showErrorToast(msg: state.error);
              isLoading = false;
              resetTimer();
            } else if (state is LoginMobileFailureState) {
              debugPrint("ERROR2:- ${state.error}");
              isLoading = false;
              resetTimer();
              showErrorToast(msg: state.error.code);
            }
            // dismissKeyboard(context);
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return Scaffold(
              body: Container(
                // height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      GreenContainerWidget(
                        child: LoginContainerTextWidget(
                          text: "Mobile Number Verification",
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: isLoading
                                ? buildLoadingIndicator()
                                : buildVerifyOTP(context, state),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildVerifyOTP(BuildContext context, LoginState state) {
    return Column(
      children: [
        SizedBox(height: 60),
        Text(
          "We have sent you One Time\nPassword to your Mobile",
          style: TextStyle(fontSize: 10.5.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        /*isError != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      isError ? Icons.close : Icons.done,
                      color: isError
                          ? Color.fromRGBO(201, 0, 0, 1)
                          : Color.fromRGBO(50, 139, 91, 1),
// color: Color.fromRGBO(201, 0, 0, 1),
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      child: Text(
                        isError ? " Incorrect OTP" : "OTP verified",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 21,
                          color: isError
                              ? Color.fromRGBO(201, 0, 0, 1)
                              : Color.fromRGBO(50, 139, 91, 1),
// color: Color.fromRGBO(201, 0, 0, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),*/
        SizedBox(height: 10),
        Text(
          "Please Enter OTP",
          style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        if (isTimer)
          Text(
            "00:" + _time.toString(),
            style: TextStyle(fontSize: 12.5.sp),
            textAlign: TextAlign.center,
          ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          height: 80,
          width: 350,
// padding: EdgeInsets.all(10),
          /*child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _textFieldOTP(first: true, last: false),
              _textFieldOTP(first: false, last: false),
              _textFieldOTP(first: false, last: false),
              _textFieldOTP(first: false, last: false),
              _textFieldOTP(first: false, last: false),
              _textFieldOTP(first: false, last: true),
            ],
          ),*/
        ),
        PinPut(
          eachFieldPadding: EdgeInsets.only(left: 10, right: 10),
          enabled: true,
          autofocus: true,
          controller: otpController,
          fieldsCount: 6,
          submittedFieldDecoration: pinPutDecoration,
          selectedFieldDecoration: selectedDecoration,
          followingFieldDecoration: pinPutDecoration,
          /* validator: (value) {
            return "error";
          },*/
          textStyle: TextStyle(
              color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        if (!isTimer)
          InkWell(
            onTap: () {
              isLoading = true;
              registerUser(context);
              setState(() {});
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "Resend OTP",
                style: TextStyle(fontSize: 12.5.sp),
              ),
            ),
          ),
        SizedBox(height: 20),
        (state is LoginInProgressState)
            ? Center(child: CircularProgressIndicator())
            : ButtonWidget(
                text: "Verify",
                color: greenColor,
                onPressed: () {
                  if (otpController.text != '' &&
                      otpController.text.length == 6) {
                    BlocProvider.of<LoginBloc>(context).add(
                      VerifyOTPButtonPressed(
                          mobileNumber: mobile,
                          phoneAuthCredential: PhoneAuthProvider.credential(
                              verificationId: verificationCodeId,
                              smsCode: otpController.text)),
                    );
                  } else {
                    // isError = true;
                    // setState(() {});
                    showErrorToast(msg: "Wrong OTP");
                    // Navigator.pushNamed(context, "/role_selection_screen");
                  }
                },
              ),
      ],
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      heightFactor: 12,
      child: Column(
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_time < 1) {
            resetTimer();
          } else {
            _time = _time - 1;
            isTimer = true;
          }
        },
      ),
    );
  }

  resetTimer() {
    _timer.cancel();
    isTimer = false;
    _time = 30;
    setState(() {});
  }

  Future registerUser(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: mobile,
      codeSent: (String verificationId, [int forceResendingToken]) {
        //debugPrint("codeSent");
        verificationCodeId = verificationId;
        startTimer();
        isLoading = false;
        setState(() {});
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        //debugPrint("verificationCompleted");
        otpController.text = phoneAuthCredential.smsCode;
        BlocProvider.of<LoginBloc>(context).add(
          VerifyOTPButtonPressed(phoneAuthCredential: phoneAuthCredential),
        );
      },
      verificationFailed: (FirebaseAuthException authException) {
        showErrorToast(msg: authException.code);
        isLoading = false;
        setState(() {});
        resetTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //debugPrint("codeAutoRetrievalTimeout");
        // Auto-resolution timed out...
      },
    );
  }

  _textFieldOTP({bool first, last}) {
    return Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 0.80,
        child: TextField(
// autofocus: true,
          autocorrect: true,
          onChanged: (value) {
            if (value == '') {
              List<String> temp = [];
              temp.addAll(enteredOtp.characters.toList());
              temp.removeLast();
              String newOtp = '';
              temp.forEach((element) {
                newOtp += element;
              });
              debugPrint("EnterdOtp => $newOtp");
              enteredOtp = newOtp;
            } else {
              enteredOtp += value.toString();
            }
            debugPrint("Value => $value");
            debugPrint("OTP => $enteredOtp");

            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: isError == null
                    ? Colors.blue
                    : isError
                        ? Color.fromRGBO(201, 0, 0, 1)
                        : Color.fromRGBO(50, 139, 91, 1),
//color: isError ? Colors.red : Colors.green,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     width: 1,
            //     color: isError
            //         ? Color.fromRGBO(201, 0, 0, 1)
            //         : Color.fromRGBO(50, 139, 91, 1),
            //   ),
            //   borderRadius: BorderRadius.circular(6),
            // ),
          ),
        ),
      ),
    );
  }
}
