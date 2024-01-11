import 'package:flutter/material.dart';

class MyProfileTile extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;

  const MyProfileTile({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(title),
        )),
      ),
    );
  }
}
