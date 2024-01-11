import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/helper/auth/AuthHelper.dart';
import 'package:geo_fresh/model/PostOffice.dart';
import 'package:geo_fresh/model/dropdown_data_model.dart';
import 'package:geo_fresh/model/farmer_notification_model.dart';
import 'package:geo_fresh/model/product_model.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/constant_data.dart';

part 'farmer_event.dart';
part 'farmer_state.dart';

class FarmerBloc extends Bloc<FarmerEvent, FarmerState> {
  FarmerBloc() : super(FarmerInitial());

  @override
  Stream<FarmerState> mapEventToState(
    FarmerEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is FarmerInitialEvent) {
        yield FarmerFetchDataProgressState();
        List<DropDownDataModel> cropTitleList =
            await AuthHelper().getProductTitle().catchError((ERROR) {
          debugPrint("error $ERROR");
        });
        // List<DropDownDataModel> cropCategoryList =
        //     await AuthHelper().getProductCategory();
        // List<DropDownDataModel> cropVarietyList =
        //     await AuthHelper().getProductVariety();
        yield FarmerInitialSuccess(cropTitleModel: cropTitleList);
      } else if (event is FetchPinCodeData) {
        // yield FarmerFetchDataProgressState();
        List<PinCodeAddressModel> addressList =
            await AuthHelper().getPinCodeData(event.pinCode);
        if (addressList != null) {
          yield FetchPinCodeAddressSuccess(addressList: addressList);
        } else {
          yield FarmerFailureState(error: "Wrong PinCode");
        }
      } else if (event is AddRegistrationOfFarmer) {
        yield FarmerInProgressState();
        await AuthHelper().addFarmerRegistration(event.userModel);
        await UserRepository().setSecureValue(ROLE, FARMER);
        yield RegistrationSuccess();
      } else if (event is AddProductOfFarmer) {
        yield FarmerInProgressState();
        await AuthHelper().addFarmerProduct(event.productModel);
        yield ProductAddSuccess();
      } else if (event is FetchFarmerProducts) {
        yield FarmerInProgressState();
        List<FarmerProductModel> response = await AuthHelper().getFarmerItems();
        // FarmerNotificationModel farmerNotificationModel =
        //     FarmerNotificationModel.fromJson(response);
        yield FetchFarmerProductsSuccess(farmerNotificationModel: response);
      }
      /*else if (event is GetPickUpAddress) {
        yield FarmerInProgressState();
        List<ProductListModel> response = await AuthHelper().getPickUpAddress();
        yield GetPickUpAddress(message: "message");
      }*/
      /*else if (event is FetchPickUpFullAddress) {
        yield FarmerInProgressState();
        List<ProductListModel> response =
            await AuthHelper().getAllProductListForBusinessman();
        // ProductListModelNew productListModelNew =
        //     ProductListModelNew.fromJson(response);
        yield FetchPickUpFullAddress(fetchPickUpAddres: response);
      }*/
    } catch (e) {
      yield FarmerFailureState(error: e.toString());
    }
  }
}
