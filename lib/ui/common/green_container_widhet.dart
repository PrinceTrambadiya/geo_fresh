import 'package:flutter/material.dart';
import 'package:geo_fresh/ui/common/go_fresh_image_widhet.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class GreenContainerWidget extends StatelessWidget {
  final Widget child;

  const GreenContainerWidget({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.5.h,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0))),
            height: 39.5.h,
            width: MediaQuery.of(context).size.width,
            child: child,
          ),
          Align(alignment: Alignment.bottomCenter, child: GoFreshImageWidget()),
        ],
      ),
    );
  }
}
