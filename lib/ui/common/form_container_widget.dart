import 'package:flutter/material.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class FormContainerWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final GestureTapCallback onTap;
  bool iconVisible;

  FormContainerWidget(
      {Key key,
      this.labelText,
      this.hintText,
      this.iconData,
      this.onTap,
      this.iconVisible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              color: textFieldColor,
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Container(
                // height: 8.0.h,
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Container(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        labelText,
                        style:
                            TextStyle(fontSize: 12.5, color: lightBlackColor),
                      ),
                      SizedBox(
                        height: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hintText,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10.9.sp, color: Colors.grey[600]),
                            ),
                            Visibility(
                              visible: iconVisible,
                              child: Icon(
                                iconData,
                                size: 25,
                                color: lightBlackColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
      ),
    );
  }
}
