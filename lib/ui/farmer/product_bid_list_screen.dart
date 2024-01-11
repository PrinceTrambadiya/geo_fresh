import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/model/bid_model.dart';
import 'package:geo_fresh/model/farmer_notification_model.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/ui/common/common_alert_dialog.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ProductBidListScreen extends StatefulWidget {
  final arguments;

  const ProductBidListScreen({Key key, this.arguments}) : super(key: key);
  @override
  _ProductBidListScreenState createState() => _ProductBidListScreenState();
}

class _ProductBidListScreenState extends State<ProductBidListScreen> {
  List<BidModel> bids = [];
  FarmerProductModel productModel;
  UserModel userModel = UserModel();
  @override
  void initState() {
    // TODO: implement initState
    productModel = widget.arguments['product'];
    userModel = widget.arguments['userModel'];
    if (productModel.bid != null) {
      productModel.bid.forEach((bid) {
        bid.title = productModel.title;
        bids.add(bid);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<FarmerBloc, FarmerState>(
        listener: (context, state) {
          if (state is FetchFarmerProductsSuccess) {
          } else if (state is FarmerFailureState) {
            showErrorToast(msg: state.error);
          }
        },
        child: BlocBuilder<FarmerBloc, FarmerState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              title: Text(
                "My Bids",
                style: TextStyle(fontSize: 13.5.sp),
              ),
              backgroundColor: greenColor,
            ),
            body: (state is FarmerInProgressState)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(5.0),
                    child: bids.isEmpty
                        ? buildEmptyNotification()
                        : ListView.builder(
                            itemCount: bids.length,
                            itemBuilder: (context, index) {
                              return bidCard(bids[index]);
                            }),
                  ),
          );
        }),
      ),
    );
  }

  Widget bidCard(BidModel bid) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: InkWell(
        onTap: () {
          showConfirmBox();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: greenColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: 'Business Name: ',
                        style: TextStyle(color: blackColor, fontSize: 11.5.sp),
                        children: [
                      TextSpan(
                          text: bid.businessName,
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
                SizedBox(height: 1.0.h),
                RichText(
                    text: TextSpan(
                        text: 'Owner Name: ',
                        style: TextStyle(color: blackColor, fontSize: 11.5.sp),
                        children: [
                      TextSpan(
                          text: bid.businessName,
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
                SizedBox(height: 1.0.h),
                RichText(
                    text: TextSpan(
                        text: 'Price: ',
                        style: TextStyle(color: blackColor, fontSize: 11.5.sp),
                        children: [
                      TextSpan(
                          text: bid.prices,
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
                SizedBox(height: 1.0.h),
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: 'Date: ',
                        style: TextStyle(color: blackColor, fontSize: 11.5.sp),
                        children: [
                          TextSpan(
                              text: bid.createAt,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    /*if (bid.status == 0)
                      bidStatus("Pending", Colors.red)
                    else if (bid.status == 1)
                      bidStatus("In progress", Colors.yellow)
                    else
                      bidStatus("Delivered", Colors.green)*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bidStatus(String status, Color color) {
    return Expanded(
      child: RichText(
        textAlign: TextAlign.end,
        text: TextSpan(
          text: status,
          style: TextStyle(
            color: color,
            fontSize: 11.5.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                title: "Confirm Businessman",
                confirmText: "Confirm",
                cancelText: "Cancel",
                showCancelIcon: true,
                subTitle:
                    "Are you sure you want to confirm this businessman for your product?",
                onConfirm: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/farmer_bank_details_form',
                      arguments: {
                        "product": productModel,
                        "userModel": userModel
                      });
                },
                onCancel: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
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
