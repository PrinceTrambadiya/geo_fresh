import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/helper/auth/AuthHelper.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/constant_data.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is CheckStatusOfUser) {
        yield DashboardInProgressState();
        UserModel userModel;

        String role = await UserRepository().readSecureValue(ROLE);
        int response = await AuthHelper().checkUserStatus();
        if (role == FARMER) {
          userModel = await AuthHelper().getFarmerDetails();
        } else {
          userModel = await AuthHelper().getBusinessManDetails();
        }
        bool status = int.parse(response.toString()) == 0 ? false : true;
        yield FetchStatusSuccess(
          status: status,
          userModel: userModel,
        );
      }
    } catch (e) {
      yield DashboardFailureState(error: e.toString());
    }
  }
}
