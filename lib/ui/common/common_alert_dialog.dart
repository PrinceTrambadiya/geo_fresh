import 'package:flutter/material.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class CommonAlertDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  bool showCancelIcon;

  CommonAlertDialog(
      {Key key,
      this.title,
      this.subTitle,
      this.confirmText,
      this.cancelText,
      this.onConfirm,
      this.onCancel,
      this.showCancelIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 60,
              color: greenColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 13.0.sp,
                          color: whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: showCancelIcon,
                    child: IconButton(
                        icon: Icon(Icons.close, color: whiteColor),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                        text: TextSpan(
                            text: subTitle,
                            style: TextStyle(
                                color: blackColor, fontSize: 12.0.sp))),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GreenBorderButtonWidget(
                            text: cancelText, onPressed: onCancel),
                        GreenBorderButtonWidget(
                            text: confirmText, onPressed: onConfirm)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
