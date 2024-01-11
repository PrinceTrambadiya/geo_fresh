import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/helper/auth/AuthHelper.dart';
import 'package:geo_fresh/model/PostOffice.dart';
import 'package:geo_fresh/model/product_list_model.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/constant_data.dart';

part 'businessman_event.dart';
part 'businessman_state.dart';

class BusinessmanBloc extends Bloc<BusinessmanEvent, BusinessmanState> {
  BusinessmanBloc() : super(BusinessmanInitial());

  @override
  Stream<BusinessmanState> mapEventToState(
    BusinessmanEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is AddRegistrationOfBusinessman) {
        yield BusinessmanInProgressState();
        await AuthHelper().addBusinessmanRegistration(event.userModel);
        await UserRepository().setSecureValue(ROLE, BUSINESS);
        yield BusinessmanRegistrationSuccess();
      } else if (event is FetchPinCodeAddress) {
        yield BusinessFetchDataProgressState();
        List<PinCodeAddressModel> addressList =
            await AuthHelper().getPinCodeData(event.pinCode);
        if (addressList != null) {
          yield FetchPinCodeSuccess(addressList: addressList);
        } else {
          yield BusinessmanFailureState(error: "Wrong PinCode");
        }
      } else if (event is FetchProductListBusinessman) {
        yield BusinessmanInProgressState();
        List<ProductListModel> response =
            await AuthHelper().getAllProductListForBusinessman();
        // ProductListModelNew productListModelNew =
        //     ProductListModelNew.fromJson(response);
        yield FetchProductListSuccess(productListModelNew: response);
      }
      if (event is CreateBid) {
        yield BusinessmanInProgressState();
        await AuthHelper().createBid(event.itemId, event.bidPrice);
        yield BidPlacedSuccess();
      }
    } catch (e) {
      yield BusinessmanFailureState(error: e.toString());
    }
  }
}
