import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFieldContainerWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  const TextFieldContainerWidget({Key key, this.color, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1.2.h),
        Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: child)),
      ],
    );
  }
}
