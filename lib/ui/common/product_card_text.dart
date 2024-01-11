import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductCardText extends StatelessWidget {
  final String leftSideText;
  final String rightSideText;

  const ProductCardText({Key key, this.leftSideText, this.rightSideText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: leftSideText + ": ",
          style: TextStyle(
              color: Colors.black,
              fontSize: 9.0.sp,
              fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
                text: rightSideText,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}
