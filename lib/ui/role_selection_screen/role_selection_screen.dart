import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fresh/bloc/login_bloc/login_bloc.dart';
import 'package:geo_fresh/ui/common/button_widget.dart';
import 'package:geo_fresh/ui/common/green_container_widhet.dart';
import 'package:geo_fresh/ui/common/login_container_text_widhet.dart';
import 'package:geo_fresh/ui/common/radio_button_container_widget.dart';
import 'package:geo_fresh/ui/common/radio_button_widget.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:geo_fresh/utils/constant_data.dart';
import 'package:sizer/sizer.dart';

class RoleSelectionScreen extends StatefulWidget {
  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String languageRadioItem = 'gj';
  String roleRadioItem = FARMER;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) {
          return LoginBloc();
        },
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state is RoleSetSuccess) {
              navigateToScreens(state.role);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      GreenContainerWidget(
                        child: LoginContainerTextWidget(
                          text: "Select Your Category",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFarmerContainer(),
                                SizedBox(width: 2.5.w),
                                buildBusinessmanContainer()
                              ],
                            ),
                            SizedBox(height: 2.5.h),
                            buildRadioButton(),
                            SizedBox(height: 3.5.h),
                            buildSubmitButton(context, state),
                            SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildFarmerContainer() {
    return RadioButtonContainerWidget(
      onTap: () {
        setState(() {
          roleRadioItem = FARMER;
        });
      },
      text: FARMER,
      image: "assets/images/farmer_image.png",
      containerColor: roleRadioItem == FARMER ? greenColor : whiteColor,
      textColor: roleRadioItem == FARMER ? whiteColor : lightBlackColor,
      radioButtonWidget: Radio(
        groupValue: roleRadioItem,
        value: FARMER,
        activeColor: whiteColor,
        onChanged: (val) {
          setState(() {
            roleRadioItem = val;
          });
        },
      ),
    );
  }

  Widget buildBusinessmanContainer() {
    return RadioButtonContainerWidget(
      onTap: () {
        setState(() {
          roleRadioItem = BUSINESS;
        });
      },
      text: BUSINESS /*"Businessman"*/,
      image: "assets/images/teacher_image.png",
      containerColor: roleRadioItem == BUSINESS ? greenColor : whiteColor,
      textColor: roleRadioItem == BUSINESS ? whiteColor : lightBlackColor,
      radioButtonWidget: Radio(
        groupValue: roleRadioItem,
        value: BUSINESS,
        activeColor: whiteColor,
        onChanged: (val) {
          setState(() {
            roleRadioItem = val;
          });
        },
      ),
    );
  }

  Widget buildRadioButton() {
    return Container(
      height: 6.0.h,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: whiteColor,
        border: Border.all(color: greenColor, width: 0.0),
        borderRadius: new BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RadioButtonWidget(
            radioButton: Radio(
              groupValue: languageRadioItem,
              value: 'gj',
              activeColor: greenColor,
              onChanged: (val) {
                setState(() {
                  languageRadioItem = val;
                });
              },
            ),
            title: "ગુજરાતી",
          ),
          RadioButtonWidget(
            radioButton: Radio(
              groupValue: languageRadioItem,
              value: 'en',
              activeColor: greenColor,
              onChanged: (val) {
                setState(() {
                  languageRadioItem = val;
                });
              },
            ),
            title: "English",
          ),
          RadioButtonWidget(
            radioButton: Radio(
              groupValue: languageRadioItem,
              value: 'hn',
              activeColor: greenColor,
              onChanged: (val) {
                setState(() {
                  languageRadioItem = val;
                });
              },
            ),
            title: "हिंदी",
          ),
        ],
      ),
    );
  }

  Widget buildSubmitButton(BuildContext context, LoginState state) {
    if (state is LoginInProgressState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ButtonWidget(
      text: "SUBMIT",
      color: greenColor,
      onPressed: () async {
        // await UserRepository().deleteAllSecureValue();

        BlocProvider.of<LoginBloc>(context)
            .add(SetRole(lan: languageRadioItem, roles: roleRadioItem));
      },
    );
  }

  navigateToScreens(String role) {
    if (role == FARMER) {
      Navigator.of(context).pushNamed('/farmer_form_screen',
          arguments: {"isEdit": false, "role": role, "lan": languageRadioItem});
    } else {
      Navigator.of(context).pushNamed('/businessman_form_screen',
          arguments: {"isEdit": false, "role": role, "lan": languageRadioItem});
    }
  }
}
