import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

showErrorToast({String msg = ''}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: redColor,
      textColor: whiteColor,
      fontSize: 12.0.sp);
}

showErrorToastBottom({String msg = ''}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: redColor,
      textColor: whiteColor,
      fontSize: 12.0.sp);
}
