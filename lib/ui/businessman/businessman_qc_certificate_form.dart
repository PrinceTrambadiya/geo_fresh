import 'package:flutter/material.dart';
import 'package:geo_fresh/ui/common/qc_certificate_card_text.dart';
import 'package:geo_fresh/utils/colors.dart';

class QcCertificate extends StatefulWidget {
  const QcCertificate({Key key}) : super(key: key);

  @override
  _QcCertificateState createState() => _QcCertificateState();
}

class _QcCertificateState extends State<QcCertificate> {
  Color whiteColor = HexColor('#FFFFFF');
  Color greenColor = HexColor('#328B5B');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "QC Certificate ",
          style: TextStyle(fontSize: 21),
        ),
        backgroundColor: greenColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4.0,
                shadowColor: greenColor.withAlpha(100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15.0),
                        alignment: Alignment.center,
                        child: Text(
                          "CERTIFICATE OF ANLAYSIS",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Divider(
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Name of the product",
                        rightSideText: "cropVariety",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Sample referance no",
                        rightSideText: "price",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Status",
                        rightSideText: "priceType",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Sample QTY",
                        rightSideText: "quantity",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Date of analysis start",
                        rightSideText: "fromDate",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Date of analysis done",
                        rightSideText: "toDate",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Analysed by",
                        rightSideText: "title",
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                elevation: 4.0,
                shadowColor: greenColor.withAlpha(100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 15.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "ANALYSIS PARAMETER",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 15.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "RESULT",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Divider(
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Colour/Appearance ",
                        rightSideText: "cropVariety",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Odour/Smell",
                        rightSideText: "price",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Admixture",
                        rightSideText: "priceType",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Purity",
                        rightSideText: "quantity",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Moisture",
                        rightSideText: "fromDate",
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      QCCertificateCardText(
                        leftSideText: "Other color seed (If Any)",
                        rightSideText: "toDate ",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
