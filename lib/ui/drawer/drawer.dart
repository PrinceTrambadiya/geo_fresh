import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/providers/user_provider.dart';
import 'package:geo_fresh/ui/common/DrawerListTile.dart';
import 'package:geo_fresh/ui/common/common_alert_dialog.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:geo_fresh/utils/constant_data.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double iconHeight = 24;
  String role, prefVerify;
  @override
  void initState() {
    // TODO: implement initState
    // if (widget.arguments != null) {
    //   isVerify = widget.arguments['userVerified'];
    // }

    getPref();

    super.initState();
  }

  UserProvider userProvider;

  getPref() async {
    role = await UserRepository().readSecureValue(ROLE);
    prefVerify = await UserRepository().readSecureValue(ISVERIFY);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      key: _scaffoldKey,
      child: ListView(
        children: <Widget>[
          Container(
            height: 150.0,
            color: greenColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5.0.w),
                    buildProfileImage(),
                    SizedBox(width: 3.0.w),
                    buildProfileData()
                  ],
                )
              ],
            ),
          ),
          DrawerListTile(
            title: "My Profile",
            image: "assets/icons/icon_profile.png",
            onTap: () {
              //Navigator.of(context).pushNamed('/my_profile');
              if (role == FARMER) {
                Navigator.of(context)
                    .pushNamed('/farmer_form_screen', arguments: {
                  "isEdit": true,
                  "role": role,
                  "lan": "gj",
                  "lan": "gj",
                  "userModel": userProvider.userModel
                });
              } else {
                Navigator.of(context).pushNamed('/businessman_form_screen',
                    arguments: {
                      "isEdit": true,
                      "role": role,
                      "lan": "gj",
                      "userModel": userProvider.userModel
                    });
              }
            },
          ),
          if (prefVerify != null) buildVerifiedUserTile(),
          DrawerListTile(
            title: "Contact Us",
            image: "assets/icons/icon_contact_us.png",
            onTap: () {
              Navigator.of(context).pushNamed('/contact_us');
            },
          ),
          DrawerListTile(
            title: "Logout",
            image: "assets/icons/icon_logout.png",
            onTap: () async {
              showConfirmBox();
            },
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    return CachedNetworkImage(
      fit: BoxFit.contain,
      imageUrl: PROFILEIMAGE,
      placeholder: (context, url) =>
          new Center(child: CircularProgressIndicator()),
      imageBuilder: (context, imageProvider) => Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }

  Widget buildProfileData() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 1.0.h),
      Text(
        userProvider.userModel.fullName,
        style: TextStyle(fontSize: 12.0.sp, color: whiteColor),
      ),
      SizedBox(height: 1.0.h),
      Text(
        userProvider.userModel.phoneNo,
        style: TextStyle(fontSize: 12.0.sp, color: whiteColor),
      ),
    ]);
  }

  Widget buildVerifiedUserTile() {
    return Column(
      children: [
        DrawerListTile(
          title: "My Business",
          image: "assets/icons/icon_business.png",
        ),
        DrawerListTile(
          title: "My Products",
          image: "assets/icons/icon_products.png",
          onTap: () {
            Navigator.of(context).pushNamed('/farmer_products_screen',
                arguments: {"userModel": userProvider.userModel});
            //   Navigator.of(context).pushNamed('/farmer_products_screen');
          },
        ),
        if (role == BUSINESS)
          DrawerListTile(
            title: "My Purchases",
            image: "assets/icons/icon_purchase.png",
            onTap: () {
              Navigator.of(context).pushNamed('/my_purchases');
            },
          ),
        if (role == BUSINESS)
          DrawerListTile(
            title: "Transport Details",
            image: "assets/icons/icon_transport.png",
            onTap: () {
              Navigator.of(context).pushNamed('/confirm_transportation');
            },
          ),
        DrawerListTile(
          title: "My Notification",
          image: "assets/icons/icon_notification.png",
          onTap: () {
            Navigator.of(context).pushNamed('/farmer_notification_screen');
          },
        ),
      ],
    );
  }

  showConfirmBox() {
    showDialog(
      context: context,
      // barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonAlertDialog(
                title: "LogOut",
                subTitle: "Are you sure you want to logOut?",
                cancelText: "No",
                confirmText: "Yes",
                onConfirm: () async {
                  await UserRepository().deleteAllSecureValue();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login_screen", (r) => false);
                },
                onCancel: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
