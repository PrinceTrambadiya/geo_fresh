import 'package:flutter/material.dart';

class QCCertificateCardText extends StatelessWidget {
  final String leftSideText;
  final String rightSideText;

  const QCCertificateCardText({Key key, this.leftSideText, this.rightSideText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15.0, top: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              leftSideText + ":-",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              rightSideText,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
