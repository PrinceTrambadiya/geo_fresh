import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/dashboard/dashboard_bloc.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/providers/user_provider.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/radio_button_container_widget.dart';
import 'package:geo_fresh/ui/drawer/drawer.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:geo_fresh/utils/constant_data.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  // final arguments;

  const Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String typeRadioItem = 'sell';
  String role = FARMER;
  bool isFarmer = false;
  bool isVerify = false;
  UserModel userModel = UserModel();

  String prefVerify;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    // if (widget.arguments != null) {
    //   isVerify = widget.arguments['userVerified'];
    // }

    getPref();

    super.initState();
  }

  getPref() async {
    role = await UserRepository().readSecureValue(ROLE);
    if (role == FARMER) {
      isFarmer = true;
    }
    prefVerify = await UserRepository().readSecureValue(ISVERIFY);
    setState(() {});
  }

  void _onRefresh(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          return DashboardBloc()..add(CheckStatusOfUser());
        },
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) async {
            if (state is FetchStatusSuccess) {
              print(state.status);
              /* print("Successfully get" +
                  state.userModel.email +
                  state.userModel.bankName);*/
              isVerify = state.status;
              userModel = state.userModel;
              UserProvider userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              userProvider.userModel = userModel;
              if (prefVerify == null && isVerify) {
                await UserRepository()
                    .setSecureValue(ISVERIFY, isVerify.toString());
              }
              _refreshController.refreshCompleted();
              setState(() {});
            } else if (state is DashboardFailureState) {
              showErrorToast(msg: state.error);
              _refreshController.refreshCompleted();
            }
          },
          child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Farm to Factory",
                    style: TextStyle(fontSize: 13.5.sp),
                  ),
                  actions: [
                    /* if (isVerify)
                      IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed('/farmer_notification_screen');
                          }),*/
                  ],
                  backgroundColor: greenColor,
                ),
                drawer: DrawerPage(),
                body: SmartRefresher(
                  enablePullDown: isVerify ? false : true,
                  scrollDirection: Axis.vertical,
                  header: WaterDropHeader(
                    waterDropColor: greenColor,
                  ),
                  controller: _refreshController,
                  onRefresh: () {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(CheckStatusOfUser());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: isVerify
                        ? buildUserVerified()
                        : buildUserNotVerified(context, state),
                  ),
                ));
          }),
        ),
      ),
    );
  }

  Widget buildUserNotVerified(BuildContext context, DashboardState state) {
    if (state is DashboardInProgressState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return userNotVerifiedCard();
  }

  Widget userNotVerifiedCard() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: greenColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Image.asset(
                  "assets/images/user_image.png",
                  height: 80,
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.fullName,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.phoneNo,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.fullAddress,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.gender,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: redColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "PENDING",
                      style: TextStyle(fontSize: 10.0.sp, color: redColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          /* child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/user_image.png",
                    height: 80,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.fullName,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.phoneNo,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.fullAddress,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          userModel.gender,
                          style:
                              TextStyle(color: greenColor, fontSize: 10.0.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: redColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "PENDING",
                        style: TextStyle(fontSize: 10.0.sp, color: redColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),*/
        ),
      ],
    );
  }

  Widget buildUserVerified() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSellContainer(),
            if (!isFarmer) SizedBox(width: 10),
            if (!isFarmer) buildBuyContainer()
          ],
        ),
      ],
    );
  }

  Widget buildSellContainer() {
    return RadioButtonContainerWidget(
      onTap: () async {
        typeRadioItem = "sell";
        if (mounted) setState(() {});
        Navigator.of(context).pushNamed('/add_product_form');
      },
      text: "SELL",
      image: "assets/images/farmer_image.png",
      containerColor: whiteColor,
      textColor: lightBlackColor,
      fontWeight: FontWeight.bold,
      fontSize: 14.0.sp,
      radioButtonWidget: Radio(
        groupValue: typeRadioItem,
        value: 'sell',
        activeColor: greenColor,
        onChanged: (val) {
          setState(() {
            typeRadioItem = val;
            Navigator.of(context).pushNamed('/add_product_form');
          });
        },
      ),
    );
  }

  Widget buildBuyContainer() {
    return RadioButtonContainerWidget(
      onTap: () {
        setState(() {
          typeRadioItem = "buy";
          Navigator.of(context).pushNamed('/product_list_screen');
        });
      },
      text: "BUY",
      image: "assets/images/buy_image.png",
      containerColor: whiteColor,
      textColor: lightBlackColor,
      fontWeight: FontWeight.bold,
      fontSize: 14.0.sp,
      radioButtonWidget: Radio(
        groupValue: typeRadioItem,
        value: 'buy',
        activeColor: greenColor,
        onChanged: (val) {
          setState(() {
            typeRadioItem = val;
            Navigator.of(context).pushNamed('/product_list_screen');
          });
        },
      ),
    );
  }
}
