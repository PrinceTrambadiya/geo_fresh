import 'package:flutter/material.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class DropDownContainerWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final BuildContext buildContext;
  final String dialogTitle;
  final Widget listViewBuilder;
  List<dynamic> list = [];

  DropDownContainerWidget(
      {Key key,
      this.labelText,
      this.hintText,
      this.iconData,
      this.buildContext,
      this.dialogTitle,
      this.list,
      this.listViewBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          if (list.isNotEmpty) {
            onTap(context);
          }
        },
        child: Container(
            decoration: BoxDecoration(
              color: textFieldColor,
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Container(
                // height: 60,
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
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
                              style: TextStyle(
                                  fontSize: 12.0.sp, color: Colors.grey[600]),
                            ),
                            Icon(
                              iconData,
                              size: 25,
                              color: lightBlackColor,
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

  onTap(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(
        context: buildContext,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 50,
                      color: greenColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              dialogTitle,
                              style: TextStyle(color: whiteColor, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        constraints:
                            BoxConstraints(maxHeight: 400, minHeight: 100),
                        child: listViewBuilder),
                  ],
                ),
              )
            ],
          );
        });
  }
}
