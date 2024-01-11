part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginInProgressState extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginInWithMobileSuccess extends LoginState {
  final String message;

  LoginInWithMobileSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class UserCreatedSuccess extends LoginState {
  final String message;

  UserCreatedSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class RoleSetSuccess extends LoginState {
  final String role;

  RoleSetSuccess({this.role});

  @override
  List<Object> get props => [role];
}

class UserRegistered extends LoginState {
  final String message;

  UserRegistered({this.message});

  @override
  List<Object> get props => [message];
}

class UserNotRegistered extends LoginState {
  final String message;

  UserNotRegistered({this.message});

  @override
  List<Object> get props => [message];
}

class UserNotVerified extends LoginState {
  final String message;

  UserNotVerified({this.message});

  @override
  List<Object> get props => [message];
}

class LoginFailureState extends LoginState {
  final String error;

  const LoginFailureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoginMobileFailureState extends LoginState {
  final FirebaseAuthException error;

  const LoginMobileFailureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
