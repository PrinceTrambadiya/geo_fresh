import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/model/product_model.dart';
import 'package:geo_fresh/ui/camera/camera_widget.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/dropdown_container_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/form_container_widget.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _productFormKey = GlobalKey<FormState>();
  TextEditingController priceController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController cropCategoryController = new TextEditingController();
  TextEditingController cropVarietyController = new TextEditingController();
  TextEditingController pinCodeController = new TextEditingController();
  TextEditingController bagsController = new TextEditingController();
  TextEditingController bagsWeightController = new TextEditingController();
  bool isChecked = false;
  ImagePicker picker = ImagePicker();
  DateTime fromDate = DateTime.now();
  ProductModel productModel = ProductModel(
      images: [],
      addressList: [],
      cropVarietyModel: [],
      cropCategoryModel: [],
      cropTitleModel: [],
      pers: ["KG", "TON", "Quintal"]);
  DateTime toDate = DateTime.now().add(Duration(days: 2));

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: fromDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fromDate) fromDate = picked;
    productModel.fromDate = fromDate.toString();
    if (mounted) setState(() {});
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: toDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fromDate) toDate = picked;
    productModel.toDate = toDate.toString();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    productModel.checkbox = 0.toString();
    productModel.fromDate = fromDate.toString();
    productModel.toDate = toDate.toString();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<FarmerBloc>(context)..add(FarmerInitialEvent());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<FarmerBloc, FarmerState>(
        listener: (context, state) {
          if (state is FarmerInitialSuccess) {
            productModel.cropTitleModel = state.cropTitleModel;
            //productModel.cropCategoryModel = state.cropCategoryModel;
            //productModel.cropVarietyModel = state.cropVarietyModel;
          } else if (state is FetchPinCodeAddressSuccess) {
            productModel.addressList = state.addressList;
            productModel.pinCode = pinCodeController.text;
            productModel.district = productModel.addressList[0].district;
            productModel.taluka = productModel.addressList[0].division;
          } else if (state is ProductAddSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/dashboard", (r) => false);
          } else if (state is FarmerFailureState) {
            showErrorToast(msg: state.error.toString());
          }
        },
        child: BlocBuilder<FarmerBloc, FarmerState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              title: Text(
                "Farm to Factory",
                style: TextStyle(fontSize: 13.5.sp),
              ),
              backgroundColor: greenColor,
            ),
            body: formBody(context, state),
          );
        }),
      ),
    );
  }

  Widget formBody(BuildContext context, FarmerState state) {
    if (state is FarmerFetchDataProgressState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _productFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Information",
                style: TextStyle(fontSize: 2.1.h, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 3.0.h),
              buildCaptureImage(),
              if (productModel.images.isNotEmpty) SizedBox(height: 10),
              if (productModel.images.isNotEmpty) buildImageList(),
              SizedBox(height: 2.0.h),
              buildLandMark(),
              buildPinCode(context, state),
              buildDistrict(),
              buildTaluka(),
              buildAreaDropDown(),
              buildTypeOfCropDropDown(),
              buildCropCategoryDropDown(),
              buildCropVarietyDropDown(),
              SizedBox(height: 1.0.h),
              Text("Select the date in which between you want to sell"),
              buildDateFields(),
              buildDescription(),
              buildPerDropDown(),
              buildPrice(),
              buildQuantityFields(),
              buildQuantity(),
              buildCheckBox(),
              SizedBox(height: 2.0.h),
              buildSaveButton(context, state),
              SizedBox(height: 2.0.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCaptureImage() {
    return Center(
      child: InkWell(
        onTap: () async {
          final cameras = await availableCameras();
          final camera = cameras.first;
          File result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraWidget(camera: camera)));

          // onCameraTap();
          setState(() {
            if (result != null) {
              productModel.images.add(result);
            } else {
              print('No image selected.');
            }
          });
        },
        child: Image.asset(
          "assets/images/capture_image.png",
          height: 100,
        ),
      ),
    );
  }

  Widget buildLandMark() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            // controller: descriptionController,
            onChanged: (value) {
              productModel.landMark = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid landmark";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Landmark*',
                hintText: "Landmark",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildPinCode(BuildContext context, FarmerState state) {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: pinCodeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            onChanged: (value) {
              // productModel.pinCode = descriptionController.text;
              if (value.length == 6) {
                BlocProvider.of<FarmerBloc>(context)
                    .add(FetchPinCodeData(pinCode: value));
              } else {
                productModel.addressList = [];
                productModel.district = '';
                productModel.taluka = '';
                productModel.area = '';
                setState(() {});
              }
            },
            validator: (val) {
              if (val == '') {
                return "Invalid pinCode";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                labelText: 'PinCode*',
                hintText: "PinCode",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildDistrict() {
    return FormContainerWidget(
      labelText: "District*",
      hintText:
          productModel.district != "" ? productModel.district : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildTaluka() {
    return FormContainerWidget(
      labelText: "Taluka*",
      hintText:
          productModel.taluka != "" ? productModel.taluka : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildAreaDropDown() {
    return DropDownContainerWidget(
      labelText: "Select Area*",
      list: productModel.addressList,
      hintText: (productModel.area == '') ? "Select Area" : productModel.area,
      iconData: Icons.arrow_drop_down,
      buildContext: context,
      dialogTitle: "Select Area",
      listViewBuilder: ListView.builder(
          shrinkWrap: true,
          itemCount: productModel.addressList.length,
          itemBuilder: (context, int index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
              // ignore: unrelated_type_equality_checks
              trailing:
                  productModel.area == productModel.addressList[index].name
                      ? Icon(
                          Icons.check,
                          color: greenColor,
                        )
                      : null,
              onTap: () {
                productModel.area = productModel.addressList[index].name;
                setState(() {});
                Navigator.pop(context);
              },
              title: Text(
                productModel.addressList[index].name,
                style: TextStyle(fontSize: 12.0.sp),
              ),
            );
          }),
    );
  }

  Widget buildTypeOfCropDropDown() {
    return DropDownContainerWidget(
      labelText: "Type of Crop*",
      list: productModel.cropTitleModel,
      hintText: (productModel.title == '') ? "Select type" : productModel.title,
      iconData: Icons.arrow_drop_down,
      buildContext: context,
      dialogTitle: "Type of Crop",
      listViewBuilder: ListView.builder(
          shrinkWrap: true,
          itemCount: productModel.cropTitleModel.length,
          itemBuilder: (context, int index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
              trailing:
                  productModel.title == productModel.cropTitleModel[index].title
                      ? Icon(
                          Icons.check,
                          color: greenColor,
                        )
                      : null,
              onTap: () {
                productModel.title = productModel.cropTitleModel[index].title;
                productModel.cropId = productModel.cropTitleModel[index].id;
                setState(() {});
                Navigator.pop(context);
              },
              title: Text(
                productModel.cropTitleModel[index].title,
                style: TextStyle(fontSize: 12.0.sp),
              ),
            );
          }),
    );
  }

  Widget buildCropCategoryDropDown() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: cropCategoryController,
            onChanged: (value) {
              productModel.cropVariety = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid crop category";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Crop Category*',
                hintText: "Crop Category",
                labelStyle: TextStyle(color: lightBlackColor))));
    /*return DropDownContainerWidget(
      labelText: "Please select crop category*",
      list: productModel.cropCategoryModel,
      hintText: (productModel.cropCat == '')
          ? "Select crop category"
          : productModel.cropCat,
      iconData: Icons.arrow_drop_down,
      buildContext: context,
      dialogTitle: "Please select crop category",
      listViewBuilder: ListView.builder(
          shrinkWrap: true,
          itemCount: productModel.cropCategoryModel.length,
          itemBuilder: (context, int index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
              trailing: productModel.cropCat ==
                      productModel.cropCategoryModel[index].title
                  ? Icon(
                      Icons.check,
                      color: greenColor,
                    )
                  : null,
              onTap: () {
                productModel.cropCat =
                    productModel.cropCategoryModel[index].title;
                setState(() {});
                Navigator.pop(context);
              },
              title: Text(
                productModel.cropCategoryModel[index].title,
                style: TextStyle(fontSize: 12.0.sp),
              ),
            );
          }),
    );*/
  }

  Widget buildCropVarietyDropDown() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: cropVarietyController,
            onChanged: (value) {
              productModel.cropCat = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid crop Variety";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Crop Variety*',
                hintText: "Crop Variety",
                labelStyle: TextStyle(color: lightBlackColor))));
    /*return DropDownContainerWidget(
      labelText: "Please select crop variety*",
      list: productModel.cropVarietyModel,
      hintText: (productModel.cropVariety == '')
          ? "Select crop variety"
          : productModel.cropVariety,
      iconData: Icons.arrow_drop_down,
      buildContext: context,
      dialogTitle: "Please select crop variety",
      listViewBuilder: ListView.builder(
          shrinkWrap: true,
          itemCount: productModel.cropVarietyModel.length,
          itemBuilder: (context, int index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
              trailing: productModel.cropVariety ==
                      productModel.cropVarietyModel[index].title
                  ? Icon(
                      Icons.check,
                      color: greenColor,
                    )
                  : null,
              onTap: () {
                productModel.cropVariety =
                    productModel.cropVarietyModel[index].title;
                setState(() {});
                Navigator.pop(context);
              },
              title: Text(
                productModel.cropVarietyModel[index].title,
                style: TextStyle(fontSize: 12.0.sp),
              ),
            );
          }),
    );*/
  }

  Widget buildDescription() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: descriptionController,
            onChanged: (value) {
              productModel.body = value;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Description',
                hintText: "Description",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildPerDropDown() {
    return DropDownContainerWidget(
      labelText: "Per*",
      list: productModel.pers,
      hintText: (productModel.priceType == '')
          ? "Select per"
          : productModel.priceType,
      iconData: Icons.arrow_drop_down,
      buildContext: context,
      dialogTitle: "Per",
      listViewBuilder: ListView.builder(
          shrinkWrap: true,
          itemCount: productModel.pers.length,
          itemBuilder: (context, int index) {
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
              trailing: productModel.priceType == productModel.pers[index]
                  ? Icon(
                      Icons.check,
                      color: greenColor,
                    )
                  : null,
              onTap: () {
                productModel.priceType = productModel.pers[index];
                setState(() {});
                Navigator.pop(context);
              },
              title: Text(
                productModel.pers[index],
                style: TextStyle(fontSize: 12.0.sp),
              ),
            );
          }),
    );
  }

  Widget buildPrice() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            keyboardType: TextInputType.number,
            controller: priceController,
            onChanged: (value) {
              productModel.price = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid price";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Price*",
                hintText: "Enter Price",
                suffixText: productModel.priceType != ''
                    ? "Per ${productModel.priceType}"
                    : "",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildQuantity() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            keyboardType: TextInputType.number,
            enabled: false,
            controller: quantityController,
            onChanged: (value) {
              productModel.quantity = value;
            },
            // validator: (val) {
            //   if (val == '') {
            //     return "Invalid quantity";
            //   }
            //   return null;
            // },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Available quantity for sell*',
                hintText: "Enter quantity",
                suffixText: productModel.priceType != ''
                    ? "Per ${productModel.priceType}"
                    : "",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildDateFields() {
    return Row(
      children: [
        SizedBox(
          width: 42.0.w,
          child: FormContainerWidget(
            labelText: "From*",
            hintText:
                "${fromDate.day} ${DateFormat.MMMM().format(fromDate).substring(0, 3)} ${fromDate.year}",
            iconData: Icons.date_range,
            onTap: () {
              _selectStartDate(context);
            },
          ),
        ),
        SizedBox(width: 3.0.w),
        SizedBox(
          width: 42.0.w,
          child: FormContainerWidget(
            labelText: "To*",
            hintText:
                "${toDate.day} ${DateFormat.MMMM().format(toDate).substring(0, 3)} ${toDate.year}",
            iconData: Icons.date_range,
            onTap: () {
              _selectEndDate(context);
            },
          ),
        ),
      ],
    );
  }

  Widget buildQuantityFields() {
    return Row(
      children: [
        SizedBox(
          width: 42.0.w,
          child: TextFieldContainerWidget(
              color: textFieldColor,
              child: TextFormField(
                  controller: bagsController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    productModel.bags = value;
                    calculateQuantity();
                  },
                  validator: (val) {
                    if (val == '') {
                      return "Invalid bags";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'No. of bags*',
                      hintText: "bags",
                      labelStyle: TextStyle(color: lightBlackColor)))),
        ),
        SizedBox(width: 3.0.w),
        SizedBox(
          width: 42.0.w,
          child: TextFieldContainerWidget(
              color: textFieldColor,
              child: TextFormField(
                  controller: bagsWeightController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    productModel.bagsWeight = value;
                    // print(bagsWeightController.text);
                    calculateQuantity();
                  },
                  validator: (val) {
                    if (val == '') {
                      return "Invalid weight";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: productModel.priceType != ''
                          ? "Weight per bag ${productModel.priceType}*"
                          : "Weight per bag",
                      hintText: "Weight",
                      labelStyle: TextStyle(color: lightBlackColor)))),
        ),
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
            text: 'Please display my ',
            style: TextStyle(color: Colors.black, fontSize: 11.0.sp),
            children: <TextSpan>[
              TextSpan(
                  text: 'Contact Number',
                  style: TextStyle(
                      color: greenColor, fontWeight: FontWeight.w500)),
              TextSpan(text: ' to the person who wants to'),
              TextSpan(
                  text: ' Purchase',
                  style: TextStyle(
                      color: greenColor, fontWeight: FontWeight.w500)),
              TextSpan(text: ' crop item'),
            ],
          ),
        ));
  }

  showImages(File image) {
    showDialog<void>(
      context: context,
      // barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return Scaffold(
          backgroundColor: transparentColor,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: blackColor,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Image.file(image)),
            ),
          ),
        );
      },
    );
  }

  Widget buildImageList() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildImage(productModel.images[index], () {
            productModel.images.removeAt(index);
            setState(() {});
          });
        },
        itemCount: productModel.images.length,
      ),
    );
  }

  Widget buildImage(File image, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          InkWell(
            onTap: () {
              showImages(image);
              dismissKeyboard(context);
            },
            child: Container(
              child: Image.file(
                image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: -15,
            top: -15,
            child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: blackColor,
                ),
                onPressed: onPressed),
          )
        ],
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
        width: 30.0.w,
        child: ButtonWidget(
          color: greenColor,
          text: "Save",
          onPressed: () {
            onSaveButton(context, state);
          },
        ),
      ),
    );
  }

  onSaveButton(BuildContext context, FarmerState state) {
    if (_productFormKey.currentState.validate() && checkForm()) {
      BlocProvider.of<FarmerBloc>(context)
          .add(AddProductOfFarmer(productModel: productModel));
    }
  }

  bool checkForm() {
    if (productModel.images.length < 2 || productModel.images.length > 5) {
      showErrorToast(msg: "Please capture images between 2 or 5 ");
      return false;
    }
    if (productModel.district != '' &&
            productModel.taluka != '' &&
            productModel.title != '' &&
            productModel.area != '' &&
            productModel.priceType != '' &&
            productModel.landMark != '' &&
            productModel.fromDate != '' &&
            productModel.toDate != '' &&
            productModel.pers != '' &&
            productModel.bags != '' &&
            productModel.quantity !=
                '' /* &&
        productModel.cropCat != '' &&
        productModel.cropVariety != ''*/
        ) {
      return true;
    } else {
      showErrorToast(msg: "Select all values");
      return false;
    }
  }

  void calculateQuantity() {
    if (bagsController.text != '' && bagsWeightController.text != '') {
      quantityController.text = '';
      quantityController.text = (int.parse(bagsController.text.toString()) *
              int.parse(bagsWeightController.text.toString()))
          .toString();
      productModel.quantity = quantityController.text;
    } else {
      quantityController.text = '';
    }
  }
/*DropDownContainerWidget(
                labelText: "Select district*",
                hintText: (productModel.district == '')
                    ? "Select district"
                    : productModel.district,
                iconData: Icons.arrow_drop_down,
                buildContext: context,
                dialogTitle: "Select district",
                listViewBuilder: ListView.builder(
                    shrinkWrap: true,
                    itemCount: addressList.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        dense: true,
                        contentPadding:
                            EdgeInsets.only(left: 10.0, right: 10.0),
                        trailing:
                            productModel.district == addressList[index].district
                                ? Icon(
                                    Icons.check,
                                    color: greenColor,
                                  )
                                : null,
                        onTap: () {
                          productModel.district = addressList[index].district;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        title: Text(
                          addressList[index].district,
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      );
                    }),
              ),
              DropDownContainerWidget(
                labelText: "Select taluka*",
                list: addressList,
                hintText: (productModel.taluka == '')
                    ? "Select taluka"
                    : productModel.taluka,
                iconData: Icons.arrow_drop_down,
                buildContext: context,
                dialogTitle: "Select taluka",
                listViewBuilder: ListView.builder(
                    shrinkWrap: true,
                    itemCount: addressList.length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        dense: true,
                        contentPadding:
                            EdgeInsets.only(left: 10.0, right: 10.0),
                        // ignore: unrelated_type_equality_checks
                        trailing:
                            productModel.taluka == addressList[index].division
                                ? Icon(
                                    Icons.check,
                                    color: greenColor,
                                  )
                                : null,
                        onTap: () {
                          productModel.taluka = addressList[index].division;
                          setState(() {});
                          Navigator.pop(context);
                        },
                        title: Text(
                          addressList[index].division,
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      );
                    }),
              ),*/
}
