part of 'businessman_bloc.dart';

abstract class BusinessmanState extends Equatable {
  const BusinessmanState();
}

class BusinessmanInitial extends BusinessmanState {
  @override
  List<Object> get props => [];
}

class BusinessFetchDataProgressState extends BusinessmanState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchPinCodeSuccess extends BusinessmanState {
  final List<PinCodeAddressModel> addressList;

  FetchPinCodeSuccess({this.addressList});

  @override
  List<Object> get props => [addressList];
}

class BusinessmanInProgressState extends BusinessmanState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class BidInProgressState extends BusinessmanState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class BidPlacedSuccess extends BusinessmanState {
  final String message;

  BidPlacedSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class BusinessmanRegistrationSuccess extends BusinessmanState {
  final String message;

  BusinessmanRegistrationSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class BusinessmanFailureState extends BusinessmanState {
  final String error;

  const BusinessmanFailureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'BusinessMan { error: $error }';
}

class FetchProductListSuccess extends BusinessmanState {
  final List<ProductListModel> productListModelNew;

  FetchProductListSuccess({this.productListModelNew});

  @override
  List<Object> get props => [productListModelNew];
}
