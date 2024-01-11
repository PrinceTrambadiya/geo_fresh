import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/utils/colors.dart';

class ShowImage extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const ShowImage({Key key, this.image, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          image.contains("https")
              ? buildProfileImage()
              : Container(
                  child: Image.file(
                    File(image),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
          Positioned(
            right: -12,
            top: -12,
            child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: redColor,
                  size: 20,
                ),
                onPressed: onPressed),
          )
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    print("fetch successfully" + image);
    return Container(
      height: 100,
      width: 100,
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: image,
        errorWidget: (context, url, error) => new Icon(Icons.error),
      ),
    );
  }
}
