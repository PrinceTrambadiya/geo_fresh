import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/farmer_bloc/farmer_bloc.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/error_toast.dart';
import 'package:geo_fresh/ui/common/form_container_widget.dart';
import 'package:geo_fresh/ui/common/go_fresh_image_widhet.dart';
import 'package:geo_fresh/ui/common/radio_button_widget.dart';
import 'package:geo_fresh/ui/common/show_image.dart';
import 'package:geo_fresh/ui/common/textfield_container_widget.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:geo_fresh/utils/constant_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class FarmerFormScreen extends StatefulWidget {
  final argument;

  const FarmerFormScreen({Key key, this.argument}) : super(key: key);
  @override
  _FarmerFormScreenState createState() => _FarmerFormScreenState();
}

class _FarmerFormScreenState extends State<FarmerFormScreen> {
  bool isEdit = false;
  UserModel userModel = UserModel();
  DateTime _selectedDate;
  final picker = ImagePicker();
  final GlobalKey<FormState> _farmerFormKey = GlobalKey<FormState>();
  TextEditingController mobileController;
  TextEditingController pinCodeController = new TextEditingController();
  TextEditingController bankAccountNoController = new TextEditingController();
  TextEditingController iFSCCodeController = new TextEditingController();
  TextEditingController birthDateController = new TextEditingController();

  var proofList = [
    "AADHAR CARD",
    "PANCARD",
    "ELECTION CARD",
    "PASSPORT",
    "DRIVING LICENCE"
  ];

  @override
  void initState() {
    // TODO: implement initState
    //  selectedDate = DateFormat('yyyy/MM/dd').format(fromDate);
    isEdit = widget.argument['isEdit'];

    if (isEdit) {
      userModel = widget.argument['userModel'];
    } else {
      userModel.photoIdType = "AADHAR CARD";
    }

    if (isEdit) {
      /*userModel = UserModel(
          registrationType: "seller",
          fullName: "Radha Patel",
          gender: "female",
          registrationCategory: "group",
          fullAddress: "13 rajmandir nr ram mandir",
          dateOfBirth: "1998/12/12",
          pinCode: "382350",
          district: "Ahmedabad1",
          tehsil: "Ahmedabad1",
          state: "Gujarat1",
          phoneNo: "+915641561894",
          photoIdNo: "515813168135",
          photoIdType: "Pan Card",
          companyName: "Test Company",
          alternatePhoneNo: "95231525431",
          email: "test@gmail.com",
          companyRegAddress: "Ahmedabad niokl",
          accountName: "TEst User",
          bankName: "SBI",
          accountNo: "9898989898989898",
          ifscCode: "FEFEFEF65454",
          scanCopy: PROFILEIMAGE,
          passbookImage: PROFILEIMAGE);*/
      userModel.registrationType = userModel.registrationType;
      pinCodeController.text = userModel.pinCode;
      bankAccountNoController.text = userModel.accountNo;
      iFSCCodeController.text = userModel.ifscCode;
      birthDateController.text = DateFormat('yyyy/MM/dd')
          .format(DateTime.parse(userModel.dateOfBirth));
    }
    getPref();
    super.initState();
  }

  getPref() async {
    userModel.userId = await UserRepository().readSecureValue(USER_ID);
    userModel.photoIdNo = await UserRepository().readSecureValue(MOBILE);
    mobileController = new TextEditingController(text: userModel.photoIdNo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<FarmerBloc, FarmerState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, "/dashboard", (r) => false,
                arguments: {"userVerified": false});
          } else if (state is FetchPinCodeAddressSuccess) {
            userModel.pinCode = pinCodeController.text;
            userModel.district = state.addressList[0].district;
            userModel.tehsil = state.addressList[0].division;
            userModel.state = state.addressList[0].state;
          } else if (state is FarmerFailureState) {
            showErrorToast(msg: state.error.toString());
          } else if (state is FarmerInProgressState) {}
        },
        child: BlocBuilder<FarmerBloc, FarmerState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: greenColor,
            body: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Form(
                      key: _farmerFormKey,
                      child: formBody(context, state),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: GoFreshImageWidget()),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget formBody(BuildContext context, FarmerState state) {
    // if (state is FarmerFetchDataProgressState) {
    //   return Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.0.h),
            Text(
              "Personal Information",
              style: TextStyle(fontSize: 15.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.0.h),
            buildRegistrationType(),
            buildGender(),
            buildFullName(),
            buildFullAddress(),
            buildDateOfBirth(),
            buildPinCode(context, state),
            buildDistrict(),
            buildTaluka(),
            buildState(),
            buildPhotoIdType(),
            buildPhotoIdNumber(),
            buildMobileNumber(),
            buildAlternateMobileNumber(),
            buildEmail(),
            if (userModel.registrationCategory == "group") buildCompanyName(),
            if (userModel.registrationCategory == "group")
              buildCompanyRegAddress(),
            buildAccountHolderName(),
            buildBankName(context, state),
            buildAccountNo(),
            buildConfirmAccountNo(),
            buildIFSCCode(),
            buildConfirmIFSCCode(),
            buildSelectImages(),
            SizedBox(height: 2.2.h),
            buildSubmitButton(context, state),
            SizedBox(height: 2.2.h),
          ],
        ),
      ),
    );
  }

  Widget buildFullName() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            // controller: firstNameController,
            initialValue: userModel.fullName,
            onChanged: (value) {
              userModel.fullName = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid name";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Full Name*',
                hintText: "Full Name",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildFullAddress() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            // controller: addressController,
            initialValue: userModel.fullAddress,
            onChanged: (value) {
              userModel.fullAddress = value;
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

  Widget buildDateOfBirth() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
        enableInteractiveSelection: false,
        focusNode: new AlwaysDisabledFocusNode(),
        onTap: () {
          _selectBirthDate(context);
        },
        controller: birthDateController,
        validator: (val) {
          if (val == '') {
            return "Invalid birth date";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: 'Date Of Birth*',
          hintText: "Date Of Birth",
          labelStyle: TextStyle(color: lightBlackColor),
        ),
      ),
    );
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1921),
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (picked != null) _selectedDate = picked;
    birthDateController.text = DateFormat('yyyy/MM/dd').format(_selectedDate);
    userModel.dateOfBirth = DateFormat('yyyy/MM/dd').format(_selectedDate);
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
                userModel.district = '';
                userModel.tehsil = '';
                userModel.state = '';
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
      hintText: userModel.district != "" ? userModel.district : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildTaluka() {
    return FormContainerWidget(
      labelText: "Tehsil*",
      hintText: userModel.tehsil != "" ? userModel.tehsil : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildState() {
    return FormContainerWidget(
      labelText: "State*",
      hintText: userModel.state != "" ? userModel.state : "Enter PinCode",
      onTap: () {},
      iconVisible: false,
    );
  }

  Widget buildPhotoIdType() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      /*child: TextFormField(
          // controller: panNoController,
          initialValue: "AADHAR CARD",
          onChanged: (value) {
            userModel.photoIdType = value;
          },
          validator: (val) {
            if (val == '') {
              return "Invalid id proof";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Id Proof Type*',
              hintText: "Enter Id Proof Type",
              labelStyle: TextStyle(color: lightBlackColor))),*/
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Id Proof Type*',
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: userModel.photoIdType,
            isDense: true,
            onChanged: (String newValue) {
              setState(() {
                userModel.photoIdType = newValue;
              });
            },
            items: proofList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildPhotoIdNumber() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            // controller: panNoController,
            initialValue: userModel.photoIdNo,
            onChanged: (value) {
              userModel.photoIdNo = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid id number";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Id Proof Number*",
                hintText: "Enter Id Proof Number",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildMobileNumber() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            controller: mobileController,
            keyboardType: TextInputType.phone,
            // maxLength: 10,
            enabled: false,
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                labelText: 'Mobile No*',
                hintText: "+91 9658325685",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildAlternateMobileNumber() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            keyboardType: TextInputType.phone,
            initialValue: userModel.photoIdNo,
            maxLength: 10,
            onChanged: (value) {
              userModel.alternatePhoneNo = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid mobile no";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                counterText: '',
                labelText: 'Alternate Mobile No',
                hintText: "Mobile No",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildEmail() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            // controller: emailController,
            initialValue: userModel.email,
            onChanged: (value) {
              userModel.email = value;
            },
            validator: (val) {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(val);
              if (!emailValid) {
                return "Invalid emailId";
              }

              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Email*',
                hintText: "Email",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildCompanyName() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            // controller: adharNoController,
            initialValue: userModel.companyName,
            onChanged: (value) {
              userModel.companyName = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid company name";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Company Name*',
                hintText: "Company Name",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildCompanyRegAddress() {
    return TextFieldContainerWidget(
        color: textFieldColor,
        child: TextFormField(
            initialValue: userModel.companyRegAddress,
            onChanged: (value) {
              userModel.companyRegAddress = value;
            },
            validator: (val) {
              if (val == '') {
                return "Invalid company reg address";
              }
              return null;
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'Company Reg Address*',
                hintText: "Company Reg Address",
                labelStyle: TextStyle(color: lightBlackColor))));
  }

  Widget buildAccountHolderName() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          onChanged: (value) {
            userModel.accountName = value;
          },
          initialValue: userModel.accountName,
          validator: (val) {
            if (val == '') {
              return "Invalid name";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Account Holder Name as per Bank A/C*",
              hintText: "Enter name",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildIFSCCode() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          controller: iFSCCodeController,
          onChanged: (value) {
            userModel.ifscCode = value;
          },
          validator: (val) {
            if (val == '') {
              return "Invalid IFSC Code";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "IFSC Code*",
              hintText: "Enter IFSC Code",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildConfirmIFSCCode() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          onChanged: (value) {},
          initialValue: userModel.ifscCode,
          validator: (val) {
            if (val == '' || val != iFSCCodeController.text) {
              return "Invalid IFSC Code";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Confirm IFSC Code*",
              hintText: "Enter IFSC Code",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildBankName(BuildContext context, FarmerState state) {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          onChanged: (value) {
            userModel.bankName = value;
          },
          initialValue: userModel.bankName,
          validator: (val) {
            if (val == '') {
              return "Invalid Bank Name";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Bank Name*",
              hintText: "Enter Bank Name",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildAccountNo() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          controller: bankAccountNoController,
          onChanged: (value) {
            userModel.accountNo = value;
          },
          validator: (val) {
            if (val == '') {
              return "Invalid Account No";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Account No*",
              hintText: "Enter Account No",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildConfirmAccountNo() {
    return TextFieldContainerWidget(
      color: textFieldColor,
      child: TextFormField(
          initialValue: userModel.accountNo,
          onChanged: (value) {},
          validator: (val) {
            if (val == '' || val != bankAccountNoController.text) {
              return "Invalid Account No";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Confirm Account No*",
              hintText: "Enter Account No",
              labelStyle: TextStyle(color: lightBlackColor))),
    );
  }

  Widget buildSelectImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormContainerWidget(
          labelText: "Upload Copy Of Passbook/Cancelled*",
          hintText: "Select Photo",
          iconData: Icons.image,
          onTap: () async {
            try {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);

              setState(() {
                if (pickedFile != null) {
                  userModel.passbookImage = pickedFile.path;
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
        if (userModel.passbookImage != null) SizedBox(height: 10),
        if (userModel.passbookImage != null)
          ShowImage(
              image: userModel.passbookImage,
              onPressed: () {
                userModel.passbookImage = null;
                setState(() {});
              }),
        FormContainerWidget(
          labelText: "Upload One Scan Copy Of Id Proof*",
          hintText: "Select Photo",
          iconData: Icons.image,
          onTap: () async {
            try {
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);

              setState(() {
                if (pickedFile != null) {
                  userModel.scanCopy = pickedFile.path;
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
        if (userModel.scanCopy != null) SizedBox(height: 10),
        if (userModel.scanCopy != null)
          ShowImage(
              image: userModel.scanCopy,
              onPressed: () {
                userModel.scanCopy = null;
                setState(() {});
              }),
      ],
    );
  }

  Widget buildRegistrationType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Registration Type*",
              style: TextStyle(fontSize: 10.0.sp, fontWeight: FontWeight.bold),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RadioButtonWidget(
                  radioButton: Radio(
                    groupValue: userModel.registrationType,
                    value: 'seller',
                    activeColor: greenColor,
                    onChanged: (val) {
                      setState(() {
                        userModel.registrationType = val;
                      });
                    },
                  ),
                  title: "Seller",
                )
              ],
            ),
          ],
        ),
        if (!isEdit)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Registration Category*",
                style:
                    TextStyle(fontSize: 10.0.sp, fontWeight: FontWeight.bold),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RadioButtonWidget(
                    radioButton: Radio(
                      groupValue: userModel.registrationCategory,
                      value: 'farmer',
                      activeColor: greenColor,
                      onChanged: (val) {
                        setState(() {
                          userModel.registrationCategory = val;
                        });
                      },
                    ),
                    title: FARMER,
                  ),
                  RadioButtonWidget(
                    radioButton: Radio(
                      groupValue: userModel.registrationCategory,
                      value: 'group',
                      activeColor: greenColor,
                      onChanged: (val) {
                        setState(() {
                          userModel.registrationCategory = val;
                        });
                      },
                    ),
                    title: "Group",
                  )
                ],
              ),
            ],
          ),
      ],
    );
  }

  Widget buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender*",
          style: TextStyle(fontSize: 10.0.sp, fontWeight: FontWeight.bold),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RadioButtonWidget(
              radioButton: Radio(
                groupValue: userModel.gender,
                value: 'male',
                activeColor: greenColor,
                onChanged: (val) {
                  setState(() {
                    userModel.gender = val;
                  });
                },
              ),
              title: "Male",
            ),
            RadioButtonWidget(
              radioButton: Radio(
                groupValue: userModel.gender,
                value: 'female',
                activeColor: greenColor,
                onChanged: (val) {
                  setState(() {
                    userModel.gender = val;
                  });
                },
              ),
              title: "Female",
            ),
            // RadioButtonWidget(
            //   widget: Radio(
            //     groupValue: userModel.gender,
            //     value: 'mrs',
            //     activeColor: greenColor,
            //     onChanged: (val) {
            //       setState(() {
            //         userModel.gender = val;
            //       });
            //     },
            //   ),
            //   text: "Mrs.",
            // ),
          ],
        ),
      ],
    );
  }

  Widget buildSubmitButton(BuildContext context, FarmerState state) {
    if (state is FarmerInProgressState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ButtonWidget(
      color: greenColor,
      text: isEdit ? "UPDATE" : "SUBMIT",
      onPressed: () {
        onButtonPressed(context, state);
      },
    );
  }

  onButtonPressed(BuildContext context, FarmerState state) {
    debugPrint("Check forms ==> ${checkForm()}");
    if (_farmerFormKey.currentState.validate() && checkForm()) {
      userModel.gender = userModel.gender;
      userModel.phoneNo = mobileController.text;
      BlocProvider.of<FarmerBloc>(context).add(
        AddRegistrationOfFarmer(userModel: userModel),
      );
    }
  }

  /*bool checkForm() {
    if (userModel.district == '' ||
        userModel.tehsil == '' ||
        userModel.state == '' ||
        birthDateController.text == ""  ) {
      return true;
    } else {
      showErrorToast(msg: "Select all values");
      return false;
    }
  }*/
  bool checkForm() {
    if (userModel.district == '' ||
        userModel.tehsil == '' ||
        userModel.state == '' ||
        birthDateController.text == '' ||
        userModel.registrationType == '' ||
        userModel.gender == '' ||
        userModel.fullName == '' ||
        userModel.fullAddress == '' ||
        userModel.dateOfBirth == '' ||
        userModel.pinCode == '' ||
        userModel.photoIdNo == '' ||
        userModel.photoIdType == '' ||
        mobileController.text == '' ||
        userModel.email == '' ||
        userModel.accountNo == '' ||
        userModel.ifscCode == '' ||
        userModel.passbookImage == '' ||
        userModel.scanCopy == '') {
      showErrorToast(msg: "Select all values");
      return false;
    } else if (userModel.passbookImage == null || userModel.scanCopy == null) {
      showErrorToast(msg: "Select images");
      return false;
    } else {
      return true;
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
