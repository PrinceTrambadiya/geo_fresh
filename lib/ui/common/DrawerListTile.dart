import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DrawerListTile extends StatelessWidget {
  final double iconHeight = 22;
  final String image;
  final String title;
  final GestureTapCallback onTap;

  const DrawerListTile({Key key, this.image, this.title, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: -10.0, horizontal: 16.0),
          dense: true,
          onTap: onTap,
          leading: Image.asset(
            image,
            height: iconHeight,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 11.0.sp),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
