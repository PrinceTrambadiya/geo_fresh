import 'package:flutter/material.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Us",
          style: TextStyle(fontSize: 13.5.sp),
        ),
        backgroundColor: greenColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4.0,
                  margin: EdgeInsets.zero,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        buildGeoFreshImage(),
                        SizedBox(height: 2.0.h),
                        buildName(),
                        buildContactNumber(),
                        buildEmail(),
                        //buildAddress()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGeoFreshImage() {
    return Image.asset(
      "assets/images/geo_fresh_image.png",
      height: 80,
    );
  }

  Widget buildName() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            enableInteractiveSelection: false,
            readOnly: true,
            initialValue: "Sagar chanpura",
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Name',
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildContactNumber() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            enableInteractiveSelection: false,
            initialValue: "+91 8469222323",
            readOnly: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Mobile No',
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildEmail() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            enableInteractiveSelection: false,
            readOnly: true,
            initialValue: "sagarchanpura@gmail.com",
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Email',
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildAddress() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            initialValue:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry LoremIpsum has been the industry's.",
            maxLines: 4,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Name*',
                labelStyle: TextStyle(color: lightBlackColor))));
  }
}
