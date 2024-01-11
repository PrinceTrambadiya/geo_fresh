import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/model/bid_model.dart';
import 'package:geo_fresh/model/farmer_notification_model.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class FarmerNotificationScreen extends StatefulWidget {
  @override
  _FarmerNotificationScreenState createState() =>
      _FarmerNotificationScreenState();
}

class _FarmerNotificationScreenState extends State<FarmerNotificationScreen> {
  // FarmerNotificationModel farmerNotificationModel =
  //     FarmerNotificationModel(data: [FarmerNotificationData(img: [], bid: [])]);
  List<FarmerProductModel> farmerNotifications = [];
  List<BidModel> bids = [];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<FarmerBloc>(context)..add(FetchFarmerProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<FarmerBloc, FarmerState>(
        listener: (context, state) {
          if (state is FetchFarmerProductsSuccess) {
            farmerNotifications = state.farmerNotificationModel;
            farmerNotifications.forEach((data) {
              if (data.bid != null) {
                data.bid.forEach((bid) {
                  bid.title = data.title;
                  bids.add(bid);
                });
              }
            });
            setState(() {});
          } else if (state is FarmerFailureState) {
            showErrorToast(msg: state.error);
          }
        },
        child: BlocBuilder<FarmerBloc, FarmerState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              title: Text(
                "List of Notification",
                style: TextStyle(fontSize: 13.5.sp),
              ),
              backgroundColor: greenColor,
            ),
            body: (state is FarmerInProgressState)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: bids.isEmpty
                        ? buildEmptyNotification()
                        : ListView.builder(
                            itemCount: bids.length,
                            itemBuilder: (context, index) {
                              return notificationCard(bids[index]);
                            }),
                  ),
          );
        }),
      ),
    );
  }

  Widget notificationCard(BidModel bid) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(
            "assets/images/user_image.png",
            height: 150,
          ),
          title: Text(
            bid.title,
            style: TextStyle(fontSize: 11.0.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\₹" + bid.prices,
                  style: TextStyle(fontSize: 9.0.sp),
                ),
                Text(
                  bid.createAt,
                  style: TextStyle(fontSize: 9.0.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmptyNotification() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/notification_bell_image.png",
            height: 146,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Nothing Here!!!",
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
