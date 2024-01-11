import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_fresh/bloc/businesman_bloc/businessman_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/helper/auth/AuthHelper.dart';
import 'package:geo_fresh/model/delivery_address_model.dart';
import 'package:geo_fresh/model/farmer_notification_model.dart';
import 'package:geo_fresh/model/product_list_model.dart';
import 'package:geo_fresh/providers/address_provider.dart';
import 'package:geo_fresh/ui/address_dialog/address_dialog.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/form_container_widget.dart';
import 'package:geo_fresh/ui/common/show_image.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BusinessManAddressScreen extends StatefulWidget {
  final userId;
  final arguments;
  const BusinessManAddressScreen({Key key, this.userId, this.arguments})
      : super(key: key);

  @override
  _BusinessManAddressScreenState createState() =>
      _BusinessManAddressScreenState();
}

class _BusinessManAddressScreenState extends State<BusinessManAddressScreen> {
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEdit = false;
  String addressTypeRadioItem = 'default';
  bool isChecked = false;
  AddressProvider addressProvider;
  String passbookImage = '';
  List<FarmerProductModel> farmerProducts = [];
  FarmerProductModel farmerProductModel = FarmerProductModel();

  ProductListModel productListModel = ProductListModel();
  String userId;
  String itemId;
  String deliveryAddress;
  String landmark;
  String pincode;
  String district;
  String taluka;
  String state1;

  @override
  void initState() {
    // TODO: implement initState
    farmerProductModel = widget.arguments['item'];
    WidgetsBinding.instance.addPostFrameCallback((value) {
      addressProvider.setAllValueEmpty();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addressProvider = Provider.of<AddressProvider>(context);
    return BlocListener<BusinessmanBloc, BusinessmanState>(
      listener: (context, state) {
        if (state is BusinessmanFailureState) {
          showErrorToast(
            msg: state.error.toString(),
          );
        }
      },
      child: BlocBuilder<BusinessmanBloc, BusinessmanState>(
          builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: Text(
              'Deal Done Screen with Bank Details',
              style: TextStyle(fontSize: 13.5.sp),
            ),
          ),
          body: formBody(context, state),
        );
      }),
    );
  }

  Widget formBody(BuildContext context, BusinessmanState state) {
    if (state is BusinessmanInProgressState) {
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
              Text(
                "Share Pickup and Drop Location",
                style: TextStyle(fontSize: 14.0.sp),
              ),
              SizedBox(height: 1.0.h),
              buildAddressBox(),
              SizedBox(height: 1.5.h),
              productCard(context, farmerProductModel),
              SizedBox(height: 0.5.h),
              buildSelectImages(),
              SizedBox(height: 1.0.h),
              buildCheckBox(),
              SizedBox(height: 1.0.h),
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
          buildPickUpLocation(),
          SizedBox(height: 2.0.h),
          buildDropLocation(),
          SizedBox(height: 2.0.h),
          GreenBorderButtonWidget(
            text: "CHANGE DELIVERY LOCATION",
            onPressed: () {
              dismissKeyboard(context);
              showDialog(
                  context: context,
                  builder: (_) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AddressDialog(
                            title: "Add Drop Location",
                          ),
                        ],
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  Widget buildPickUpLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pickup Location",
          style: TextStyle(fontSize: 11.0.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.0.h),
        Text(
          "12 , Gr Flr, Darshan Chs, Nursing Lane, Opp Ds Nagar,Malad (w) Mumbai, Maharashtra - 400064",
          style: TextStyle(fontSize: 11.0.sp),
        ),
      ],
    );
  }

  Widget buildDropLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Drop Location",
          style: TextStyle(fontSize: 11.0.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.0.h),
        Text(
          addressProvider.getAddress(),
          style: TextStyle(fontSize: 11.0.sp),
        ),
      ],
    );
  }

  Widget productCard(BuildContext context, FarmerProductModel productListData) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productCardText(
                          first: "Crop type", second: productListData.title),
                      productCardText(
                          first: "Crop category",
                          second: productListData.cropCat),
                      productCardText(
                          first: "Variety of crops",
                          second: productListData.cropVariety),
                      productCardText(
                          first: "Price",
                          second: productListData.price,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  if (productListData.img.isNotEmpty)
                    InkWell(
                      onTap: () {},
                      child: CachedNetworkImage(
                        imageUrl: productListData.img[0],
                        height: 66,
                        width: 66,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  SizedBox(height: 8),
                ],
              ),
              productCardText(first: "Unit", second: productListData.priceType),
              productCardText(
                  first: "Quantity",
                  second: productListData.quantity,
                  fontWeight: FontWeight.bold),
              productCardText(
                  first: "From date", second: productListData.fromDate),
              productCardText(first: "To date", second: productListData.toDate),
              SizedBox(
                width: 50.5.w,
                child: SizedBox(
                  child: TextFieldContainerWidget(
                    color: textFieldColor,
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: '1200',
                        labelStyle: TextStyle(
                          color: lightBlackColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget productCardText(
      {String first,
      String second,
      FontWeight fontWeight = FontWeight.normal}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: first + ": ",
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
                text: second,
                style: TextStyle(color: Colors.black, fontWeight: fontWeight)),
          ],
        ),
      ),
    );
  }

  Widget buildSelectImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormContainerWidget(
          labelText: "Upload Payment Receipt*",
          hintText: "Payment Receipt",
          iconData: Icons.image,
          onTap: () async {
            try {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);

              setState(() {
                if (pickedFile != null) {
                  passbookImage = pickedFile.path;
                } else {
                  print('No image selected.');
                }
              });
            } catch (e) {
              print("Error");
              if (mounted) setState(() {});
            }
          },
        ),
        if (passbookImage != '') SizedBox(height: 10),
        if (passbookImage != '')
          ShowImage(
              image: passbookImage,
              onPressed: () {
                passbookImage = null;
                setState(() {});
              })
      ],
    );
  }

  Widget buildCheckBox() {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.all(0),
        onChanged: (value) {
          setState(() {
            isChecked = value;
            // productModel.checkbox = isChecked.toString();
          });
        },
        value: isChecked,
        activeColor: greenColor,
        title: RichText(
          text: TextSpan(
              text: 'I Agree ',
              style: TextStyle(color: greenColor, fontSize: 12.0.sp)),
        ));
  }

  Widget buildButtons(BuildContext context, BusinessmanState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [buildCancelButton(), buildSaveButton(context, state)],
    );
  }

  Widget buildCancelButton() {
    return SizedBox(
      width: 43.5.w,
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
    if (state is FarmerInProgressState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: SizedBox(
        width: 43.5.w,
        child: ButtonWidget(
          color: greenColor,
          text: "SUBMIT",
          onPressed: () {
            BlocProvider.of<FarmerBloc>(context)
                .add(AddProductOfFarmer(ProductModel: this.productListModel));
            onSaveButton(context, state);
          },
        ),
      ),
    );
  }

  onSaveButton(BuildContext context, BusinessmanState state) async {
    if (_formKey.currentState.validate()) {
      debugPrint("abc");
      Map<String, dynamic> data = {
        "userId": widget.userId,
        "itemId": "2",
        "deliveryAddress": deliveryAddress,
        "landmark": landmark,
        "pincode": pincode,
        "district": district,
        "taluka": taluka,
        "state": state1,
      };

      debugPrint("hello");
      DeliverAddressModel address = await AuthHelper().addDeliveryAddress(data);
      Fluttertoast.showToast(msg: "Done Delivery address");
      if (address != null) {
        //debugPrint("Done Delivery address => $address");
      }
    }
  }

  /*onSaveButton(BuildContext context, BusinessmanState state) {
    if (_formKey.currentState.validate() && checkForm()) {
      */ /*BlocProvider.of<FarmerBloc>(context)
          .add(AddProductOfFarmer(ProductListModel: ProductListModel));*/ /*
    }
  }*/

  bool checkForm() {
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
