import 'package:cached_network_image/cached_network_image.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/ui/common/my_profile_tile.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:geo_fresh/utils/constant_data.dart';
import 'package:sizer/sizer.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String role = "";
  @override
  void initState() {
    // TODO: implement initState
    getPref();
    super.initState();
  }

  getPref() async {
    role = await UserRepository().readSecureValue(ROLE);
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
        child: Scaffold(
            body: Container(
      child: Column(
        children: [buildContainer(), buildTiles()],
      ),
    )));
  }

  Widget buildContainer() {
    return Stack(
      children: [
        Container(
          height: 35.0.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildProfileImage(),
              buildProfileData(),
            ],
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.arrow_back_sharp,
              color: whiteColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }

  Widget buildProfileImage() {
    return CachedNetworkImage(
      fit: BoxFit.contain,
      imageUrl: PROFILEIMAGE,
      placeholder: (context, url) =>
          new Center(child: CircularProgressIndicator()),
      imageBuilder: (context, imageProvider) => Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }

  Widget buildProfileData() {
    return Column(children: [
      SizedBox(height: 1.0.h),
      Text(
        "Rajesh Patel",
        style: TextStyle(fontSize: 12.0.sp, color: whiteColor),
      ),
      SizedBox(height: 1.0.h),
      Text(
        "+91 98985 98985",
        style: TextStyle(fontSize: 12.0.sp, color: whiteColor),
      ),
    ]);
  }

  Widget buildTiles() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          MyProfileTile(
            title: "Personal Information",
            onTap: () {
              if (role == FARMER) {
                Navigator.of(context).pushNamed('/farmer_form_screen',
                    arguments: {"isEdit": true, "role": role, "lan": "gj"});
              } else {
                Navigator.of(context).pushNamed('/businessman_form_screen',
                    arguments: {"isEdit": true, "role": role, "lan": "gj"});
              }
            },
          )
        ],
      ),
    );
  }
}
/*
return ColorfulSafeArea(
child: Scaffold(
body: NestedScrollView(
headerSliverBuilder:
(BuildContext context, bool innerBoxIsScrolled) {
return <Widget>[
SliverAppBar(
backgroundColor: greenColor,
iconTheme: IconThemeData(color: whiteColor),
expandedHeight: 40.0.h,
floating: false,
pinned: true,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.only(
bottomLeft: Radius.circular(50),
bottomRight: Radius.circular(50)),
),
automaticallyImplyLeading: false,
flexibleSpace: FlexibleSpaceBar(
collapseMode: CollapseMode.parallax,
background: Padding(
padding: const EdgeInsets.symmetric(
horizontal: 20, vertical: 20),
child: Column(
children: <Widget>[],
),
),
),
),
];
},
body: ListView(
children: <Widget>[
Padding(
padding: const EdgeInsets.symmetric(
vertical: 20, horizontal: 20),
child: Form(
key: _formKey,
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: <Widget>[
Card(
color: whiteColor,
child: Padding(
padding: const EdgeInsets.symmetric(
vertical: 10, horizontal: 10),
child: Column(
children: <Widget>[],
),
),
),
],
),
),
)
],
))),
);*/
