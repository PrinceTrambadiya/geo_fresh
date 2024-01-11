import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/user_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    // TODO: implement mapEventToState
    try {
      if (event is SplashInitialEvent) {
        bool isAuth = await UserRepository().hasUserId();
        await Future.delayed(Duration(seconds: 3));
        if (isAuth) {
          bool isRole = await UserRepository().hasRole();
          if (isRole) {
            yield UserHasRegistered(isRole: isRole);
          } else {
            yield UserHasNotRegistered(isRole: isRole);
          }
        } else {
          yield LoginNeeded(isAuth: isAuth);
        }
      }
    } catch (e) {
      yield SplashFailureState(error: e.toString());
    }
  }
}
