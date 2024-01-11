part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashInProgress extends SplashState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserHasRegistered extends SplashState {
  final bool isRole;

  UserHasRegistered({this.isRole});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserHasNotRegistered extends SplashState {
  final bool isRole;

  UserHasNotRegistered({this.isRole});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginNeeded extends SplashState {
  final bool isAuth;

  LoginNeeded({this.isAuth});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SplashFailureState extends SplashState {
  final String error;

  const SplashFailureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SplashFailureState { error: $error }';
}
