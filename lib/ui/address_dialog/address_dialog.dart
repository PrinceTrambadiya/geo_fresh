import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/providers/address_provider.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/form_container_widget.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddressDialog extends StatefulWidget {
  final String title;

  const AddressDialog({Key key, this.title}) : super(key: key);

  @override
  _AddressDialogState createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  TextEditingController fullAddressController = new TextEditingController();
  TextEditingController landMarkController = new TextEditingController();
  TextEditingController pinCodeController = new TextEditingController();
  AddressProvider addressProvider;
  String fullAddress = "",
      landMark = "",
      pinCode = "",
      district = "",
      tehsil = "",
      state1 = "";
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((value) {
      pinCodeController.text = addressProvider.pinCode;
      landMarkController.text = addressProvider.landMark;
      fullAddressController.text = addressProvider.fullAddress;
      district = addressProvider.district;
      tehsil = addressProvider.tehsil;
      state1 = addressProvider.state;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addressProvider = Provider.of<AddressProvider>(context);
    return BlocListener<FarmerBloc, FarmerState>(
      listener: (context, state) {
        if (state is FetchPinCodeAddressSuccess) {
          pinCode = pinCodeController.text;
          district = state.addressList[0].district;
          tehsil = state.addressList[0].division;
          state1 = state.addressList[0].state;
        } else if (state is FarmerFailureState) {
          showErrorToast(msg: state.error.toString());
        }
      },
      child: BlocBuilder<FarmerBloc, FarmerState>(builder: (context, state) {
        return Container(
          child: Dialog(
              child: Stack(
            overflow: Overflow.visible,
            children: [
              Form(
                key: _addressFormKey,
                child: Container(
                  width: 80.0.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: greenColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.title,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            buildFullAddress(),
                            buildLandMark(),
                            buildPinCode(context, state),
                            buildDistrict(),
                            buildTaluka(),
                            buildState(),
                            SizedBox(height: 2.0.h),
                            buildSaveButton(context, state),
                            SizedBox(height: 1.0.h),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
        );
      }),
    );
  }

  Widget buildFullAddress() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: fullAddressController,
            onChanged: (value) {
              fullAddress = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid address";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Full Address (Street)',
                hintText: "Full Address (Street)",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildLandMark() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: landMarkController,
            onChanged: (value) {
              landMark = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid landmark";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'LandMark*',
                hintText: "LandMark",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildPinCode(BuildContext context, FarmerState state) {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: pinCodeController,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              if (value.length == 6) {
                BlocProvider.of<FarmerBloc>(context)
                    .add(FetchPinCodeData(pinCode: value));
              } else {
                district = '';
                tehsil = '';
                state1 = '';
                setState(() {});
              }
            },
            validator: (val) {
              if (val == '') {
                return "Invalid pinCode";
              }
              return null;
            },
            maxLength: 6,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'PinCode*',
                hintText: "PinCode",
                counterText: '',
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildDistrict() {
    return FormContainerWidget(
      labelText: "District*",
      hintText: district != "" ? district : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildTaluka() {
    return FormContainerWidget(
      labelText: "Tehsil*",
      hintText: tehsil != "" ? tehsil : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildState() {
    return FormContainerWidget(
      labelText: "State*",
      hintText: state1 != "" ? state1 : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildSaveButton(BuildContext context, FarmerState state) {
    return Center(
      child: SizedBox(
        width: 30.0.w,
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

  onSaveButton(BuildContext context, FarmerState state) {
    if (_addressFormKey.currentState.validate() && checkForm()) {
      addressProvider.fullAddress = fullAddress;
      addressProvider.landMark = landMark;
      addressProvider.pinCode = pinCode;
      addressProvider.district = district;
      addressProvider.tehsil = tehsil;
      addressProvider.state = state1;
      Navigator.pop(context);
    }
  }

  bool checkForm() {
    if (district != '' && tehsil != '' && state1 != '') {
      return true;
    } else {
      showErrorToast(msg: "Select all values");
      return false;
    }
  }
}
