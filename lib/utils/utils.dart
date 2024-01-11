import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({String message}) {
  Fluttertoast.showToast(
    msg: "$message",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 24,
  );
}
