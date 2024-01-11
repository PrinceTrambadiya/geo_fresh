import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/helper/auth/AuthHelper.dart';
import 'package:geo_fresh/model/pickup_address_model.dart';
import 'package:geo_fresh/model/product_list_model.dart';
import 'package:geo_fresh/model/product_model.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/providers/address_provider.dart';
import 'package:geo_fresh/ui/address_dialog/address_dialog.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/radio_button_widget.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FarmerAddressDetailsForm extends StatefulWidget {
  final arguments;
  final userId;

  const FarmerAddressDetailsForm({Key key, this.arguments, this.userId})
      : super(key: key);

  @override
  _FarmerAddressDetailsFormState createState() =>
      _FarmerAddressDetailsFormState();
}

class _FarmerAddressDetailsFormState extends State<FarmerAddressDetailsForm> {
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEdit = false;
  String addressTypeRadioItem = 'default';
  AddressProvider addressProvider;
  UserModel userModel = UserModel();
  List<ProductListModel> full_Address = [];
  ProductModel productModel = ProductModel();

  String pickUpAddress;
  String landmark;
  String pincode;
  String district;
  String taluka;
  String state1;
  String userId;
  String itemId;

  @override
  void initState() {
    // TODO: implement initState
    userModel = widget.arguments['userModel'];
    WidgetsBinding.instance.addPostFrameCallback((value) {
      addressProvider.setAllValueEmpty();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addressProvider = Provider.of<AddressProvider>(context);
    return BlocListener<FarmerBloc, FarmerState>(
      listener: (context, state) {
        if (state is FarmerFailureState) {
          showErrorToast(msg: state.error.toString());
        }
      },
      child: BlocBuilder<FarmerBloc, FarmerState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: Text(
              'Share Pickup Location / Address',
              style: TextStyle(fontSize: 13.5.sp),
            ),
          ),
          body: formBody(context, state),
        );
      }),
    );
  }

  Widget formBody(BuildContext context, FarmerState state) {
    if (state is FarmerFetchDataProgressState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAddressBox(),
              buildAccountHolderName(),
              buildBankName(context, state),
              buildAccountNo(),
              buildIFSCCode(),
              SizedBox(height: 2.0.h),
              buildButtons(context, state),
              SizedBox(height: 2.0.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(
            color: greenColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          defaultAddressButton(),
          customAddressButton(),
          // GreenBorderButtonWidget(
          //   text: "SHARE PICKUP ADDRESS",
          //   onPressed: () {},
          // )
        ],
      ),
    );
  }

  Widget defaultAddressButton() {
    return Container(
      padding: EdgeInsets.only(right: 8, bottom: 8),
      child: AddressRadioButtonWidget(
          radioButton: SizedBox(
            height: 20,
            width: 20,
            child: Container(
              // padding: EdgeInsets.only(right: 8, bottom: 8),
              child: Radio(
                groupValue: addressTypeRadioItem,
                value: 'default',
                activeColor: greenColor,
                onChanged: (val) {
                  setState(() {
                    addressTypeRadioItem = val;
                  });
                },
              ),
            ),
          ),
          title: userModel.fullAddress +
              " " +
              // userModel.tehsil +
              // " " +
              userModel.district +
              " " +
              userModel.state +
              " " +
              userModel.pinCode
          /*"12 , Gr Flr, Darshan Chs, Nursing Lane,Opp Ds Nagar, Malad (w)Mumbai, Maharashtra - 400064",*/
          ),
    );
  }

  Widget customAddressButton() {
    return Container(
      padding: EdgeInsets.only(right: 8, bottom: 8),
      child: AddressRadioButtonWidget(
        radioButton: SizedBox(
          height: 20,
          width: 20,
          child: Container(
            // padding: EdgeInsets.only(right: 8, bottom: 8),
            child: Radio(
              groupValue: addressTypeRadioItem,
              value: 'custom',
              activeColor: greenColor,
              onChanged: (val) {
                setState(() {
                  addressTypeRadioItem = val;
                  dismissKeyboard(context);
                  showDialog(
                      context: context,
                      builder: (_) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AddressDialog(
                                title: "Add Pickup Location",
                              ),
                            ],
                          ),
                        );
                      });
                });
              },
            ),
          ),
        ),
        title: addressProvider.getAddress() != ''
            ? addressProvider.getAddress()
            : "Add Pickup Location",
        titleFontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildAccountHolderName() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
        //controller: userModel.accountName,
        onChanged: (value) {
          //userModel.accountName = value;
        },
        enabled: false,
        initialValue: userModel.accountName,
        validator: (val) {
          if (val == '') {
            return "Invalid name";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "Account Holder Name as per Bank A/C",
          hintText: "Enter name",
          labelStyle: TextStyle(color: lightBlackColor),
        ),
      ),
    );
  }

  Widget buildIFSCCode() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
        //controller: codeController,
        onChanged: (value) {},
        enabled: false,
        initialValue: userModel.ifscCode,
        validator: (val) {
          if (val == '') {
            return "Invalid IFSC Code";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "IFSC Code",
          hintText: "Enter IFSC Code",
          labelStyle: TextStyle(color: lightBlackColor),
        ),
      ),
    );
  }

  Widget buildBankName(BuildContext context, FarmerState state) {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
        //controller: bankNameController,
        onChanged: (value) {},
        enabled: false,
        initialValue: userModel.bankName,
        validator: (val) {
          if (val == '') {
            return "Invalid Bank Name";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: "Bank Name",
          hintText: "Enter Bank Name",
          labelStyle: TextStyle(color: lightBlackColor),
        ),
      ),
    );
  }

  Widget buildAccountNo() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          //controller: accountNoController,
          onChanged: (value) {},
          enabled: false,
          initialValue: userModel.accountNo,
          validator: (val) {
            if (val == '') {
              return "Invalid Account No";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Account No",
              hintText: "Enter Account No",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildButtons(BuildContext context, FarmerState state) {
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
      width: 42.5.w,
      child: GreenBorderButtonWidget(
        text: "CANCEL",
        textSize: 12.5.sp,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildSaveButton(BuildContext context, FarmerState state) {
    if (state is FarmerInProgressState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: SizedBox(
        width: 42.5.w,
        child: ButtonWidget(
          color: greenColor,
          text: "SUBMIT",
          onPressed: () {
            onSaveButton(context, state);
          },
        ),
      ),
    );
  }

  onSaveButton(BuildContext context, FarmerState state) async {
    if (_formKey.currentState.validate() /*&& checkForm() ?? ''*/) {
      //debugPrint("abc");
      Map<String, dynamic> data = {
        "pickUpAddress": pickUpAddress,
        "landmark": landmark,
        "pincode": pincode,
        "district": district,
        "taluka": taluka,
        "state": state1,
        "userId": widget.userId,
        "itemId": "2",
      };
      //debugPrint("hello");
      PickUpAddressModel address = await AuthHelper().addEditAddress(data);
      Fluttertoast.showToast(msg: "Return Toast");
      if (address != null) {
        //addressProvider.fullAddress = addressProvider.toString();
        debugPrint("Return address => $address");
        //Fluttertoast.showToast(msg: "Return Toast");
      }
    }

    /*onSaveButton(BuildContext context, FarmerState state) async {
    if (_formKey.currentState.validate()  && checkForm() ?? '' ) {
      debugPrint("abc");
      Map<String, dynamic> data = {
        "pickUpAddress": pickUpAddress,
        "landmark": landmark,
        "pincode": pincode,
        "district": district,
        "taluka": taluka,
        "state": state1,
        "userId": "278",
        "itemId": "2",
      };
      AddressModel festival = await AuthHelper().addEditAddress(data);
      debugPrint("festival: $festival");

       BlocProvider.of<FarmerBloc>(context)
          .add(AddProductOfFarmer(productModel: productModel));
    }
  }*/

    bool checkForm() {
      return true;
      // if (productModel.area != '') {
      //   return true;
      // } else {
      //   showErrorToast(msg: "Select all values");
      //   return false;
      // }
    }
  }

/*  Widget buildConfirmAccountNo() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          controller: accountNoController,
          onChanged: (value) {},
          validator: (val) {
            if (val == '') {
              return "Invalid Account No";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Confirm Account No",
              hintText: "Enter Account No",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildBranchName() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          controller: branchNameController,
          onChanged: (value) {},
          validator: (val) {
            if (val == '') {
              return "Invalid Branch Name";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Branch Name",
              hintText: "Enter Branch Name",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }*/

}
