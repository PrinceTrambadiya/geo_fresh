part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class InitialLoginEvent extends LoginEvent {
  const InitialLoginEvent();

  @override
  List<Object> get props => [];
}

class SetRole extends LoginEvent {
  final String lan;
  final String roles;

  SetRole({this.lan, this.roles});

  @override
  List<Object> get props => [lan, roles];
}

class VerifyOTPButtonPressed extends LoginEvent {
  final PhoneAuthCredential phoneAuthCredential;
  final String mobileNumber;

  const VerifyOTPButtonPressed({this.phoneAuthCredential, this.mobileNumber});

  @override
  List<Object> get props => [phoneAuthCredential, mobileNumber];

  @override
  String toString() =>
      'VerifyOTPButtonPressed { phoneAuthCredential: $phoneAuthCredential }';
}
