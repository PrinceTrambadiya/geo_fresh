part of 'businessman_bloc.dart';

abstract class BusinessmanEvent extends Equatable {
  const BusinessmanEvent();
}

class AddRegistrationOfBusinessman extends BusinessmanEvent {
  final UserModel userModel;

  const AddRegistrationOfBusinessman({this.userModel});

  @override
  List<Object> get props => [userModel];
}

class FetchPinCodeAddress extends BusinessmanEvent {
  final String pinCode;

  const FetchPinCodeAddress({this.pinCode});

  @override
  List<Object> get props => [pinCode];
}

class FetchProductListBusinessman extends BusinessmanEvent {
  const FetchProductListBusinessman();

  @override
  List<Object> get props => [];
}

class CreateBid extends BusinessmanEvent {
  final String itemId;
  final String bidPrice;

  CreateBid({this.itemId, this.bidPrice});

  @override
  List<Object> get props => [];
}
