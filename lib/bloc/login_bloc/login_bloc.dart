import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/helper/auth/AuthHelper.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/constant_data.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  String mobileNumber = '';
  UserCredential userCredential;
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is InitialLoginEvent) {
        yield LoginInitial();
      } else if (event is VerifyOTPButtonPressed) {
        yield LoginInProgressState();
        var userData;
        mobileNumber = event.mobileNumber;
        try {
          userCredential =
              await AuthHelper().loginWithMobile(event.phoneAuthCredential);
          Map<String, dynamic> result = await AuthHelper()
              .checkMobileNumber(userCredential.user.phoneNumber);

          switch (result['statusCode']) {
            case 200:
              userData = await AuthHelper()
                  .createNewUser(userCredential.user.phoneNumber);
              await setOldUserPref(userData);
              yield LoginInWithMobileSuccess(message: "Login Success");

              break;
            case 202:
              userData =
                  await AuthHelper().loginUser(userCredential.user.phoneNumber);

              if (!result['isRegistered']) {
                await setNewUserPref(userData);

                yield UserNotRegistered(message: "You are not registered");
                return;
              }

              if (userData['statusCode'] == 200) {
                await setNewUserPref(userData);
                yield UserRegistered(message: "Login Success");
              } else if (userData['statusCode'] == 201) {
                // await UserRepository()
                //     .setSecureValue(ROLE, userData['data']['roles']);
                // await UserRepository()
                //     .persistId(userData['data']['id'].toString());
                // await UserRepository()
                //     .persistToken(userData['data']['api_token']);
                await setNewUserPref(userData);
                yield UserNotVerified(message: "You are not registered");
              }
            // await setPref(userData);
            // yield LoginInWithMobileSuccess(message: "Login Success");
            // break;
          }
        } catch (FirebaseAuthException) {
          yield LoginMobileFailureState(error: FirebaseAuthException);
          // yield LoginFailureState(error: e.toString());
        }
      } else if (event is SetRole) {
        yield LoginInProgressState();
        await AuthHelper().setRole(event.lan, event.roles);
        yield RoleSetSuccess(role: event.roles);
      }
    } catch (e) {
      yield LoginFailureState(error: e.toString());
    }
  }

  setNewUserPref(var userData) async {
    if (userData['data']['id'] != null) {
      await UserRepository().persistId(userData['data']['id'].toString());
    }
    if (userData['data']['api_token'] != null) {
      await UserRepository().persistToken(userData['data']['api_token']);
    }
    if (userData['data']['roles'] != null) {
      await UserRepository().setSecureValue(ROLE, userData['data']['roles']);
    }
    await UserRepository()
        .setSecureValue(MOBILE, userCredential.user.phoneNumber);
  }

  setOldUserPref(var userData) async {
    await UserRepository().persistId(userData['user_id'].toString());
    await UserRepository().persistToken(userData['api_token'].toString());
    await UserRepository()
        .setSecureValue(MOBILE, userCredential.user.phoneNumber);
  }
}
