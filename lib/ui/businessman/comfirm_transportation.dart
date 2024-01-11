import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/businesman_bloc/businessman_bloc.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:sizer/sizer.dart';

class ConfirmTransportation extends StatefulWidget {
  @override
  _ConfirmTransportationState createState() => _ConfirmTransportationState();
}

class _ConfirmTransportationState extends State<ConfirmTransportation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transport Details",
          style: TextStyle(fontSize: 13.5.sp),
        ),
      ),
      body: BlocListener<BusinessmanBloc, BusinessmanState>(
        listener: (context, state) {
          if (state is BusinessmanFailureState) {
            showErrorToast(msg: state.error.toString());
          }
        },
        child: BlocBuilder<BusinessmanBloc, BusinessmanState>(
            builder: (context, state) {
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: greenColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            buildLeftSide(),
                            buildRightSide(),
                          ],
                        ),
                        SizedBox(height: 2.0.h),
                        buildButtons(context, state),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget buildLeftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: 'Total No Of Kilometers : ',
                style: TextStyle(color: blackColor, fontSize: 11.5.sp))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: 'Total Kilometers Amount: ',
                style: TextStyle(color: blackColor, fontSize: 11.5.sp))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: 'Product Load/ unload: ',
                style: TextStyle(color: blackColor, fontSize: 11.5.sp))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: 'Extra Money: ',
                style: TextStyle(color: blackColor, fontSize: 11.5.sp))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: 'Other Charges: ',
                style: TextStyle(color: blackColor, fontSize: 11.5.sp)))
      ],
    );
  }

  Widget buildRightSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: '50km',
                style: TextStyle(
                    color: blackColor,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.bold))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: '1100.00',
                style: TextStyle(
                    color: blackColor,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.bold))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: '500.00',
                style: TextStyle(
                    color: blackColor,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.bold))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: '2200.00',
                style: TextStyle(
                    color: blackColor,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.bold))),
        SizedBox(height: 1.0.h),
        RichText(
            text: TextSpan(
                text: '1100.00',
                style: TextStyle(
                    color: blackColor,
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.bold)))
      ],
    );
  }

  Widget buildButtons(BuildContext context, BusinessmanState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCancelButton(),
        SizedBox(width: 2.0.w),
        buildSaveButton(context, state)
      ],
    );
  }

  Widget buildCancelButton() {
    return SizedBox(
      width: 40.5.w,
      child: GreenBorderButtonWidget(
        text: "CANCEL",
        textSize: 12.5.sp,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildSaveButton(BuildContext context, BusinessmanState state) {
    return Center(
      child: SizedBox(
        width: 40.5.w,
        child: ButtonWidget(
          color: greenColor,
          text: "CONFIRM",
          onPressed: () {},
        ),
      ),
    );
  }
}
