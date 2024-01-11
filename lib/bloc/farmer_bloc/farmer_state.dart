part of 'farmer_bloc.dart';

abstract class FarmerState extends Equatable {
  const FarmerState();
}

class FarmerInitial extends FarmerState {
  @override
  List<Object> get props => [];
}

class FarmerInitialSuccess extends FarmerState {
  final List<DropDownDataModel> cropTitleModel;
  final List<DropDownDataModel> cropVarietyModel;
  final List<DropDownDataModel> cropCategoryModel;

  FarmerInitialSuccess(
      {this.cropTitleModel, this.cropVarietyModel, this.cropCategoryModel});

  @override
  List<Object> get props =>
      [cropTitleModel, cropVarietyModel, cropCategoryModel];

  @override
  String toString() => 'FarmerInitialSuccess { cropTitle= : $cropTitleModel }';
}

class FarmerInProgressState extends FarmerState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FarmerFetchDataProgressState extends FarmerState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchPinCodeAddressSuccess extends FarmerState {
  final List<PinCodeAddressModel> addressList;

  FetchPinCodeAddressSuccess({this.addressList});

  @override
  List<Object> get props => [addressList];
}

class RegistrationSuccess extends FarmerState {
  final String message;

  RegistrationSuccess({this.message});

  @override
  List<Object> get props => [message];
}

/*class FetchPickUpFullAddress extends FarmerState {
  final List<ProductListModel> fetchPickUpAddres;

  FetchPickUpFullAddress({this.fetchPickUpAddres});

  @override
  List<Object> get props => [fetchPickUpAddres];
}*/

class ProductAddSuccess extends FarmerState {
  final String message;

  ProductAddSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class ProductBidPriceAddSuccess extends FarmerState {
  final String message;

  ProductBidPriceAddSuccess({this.message});

  @override
  List<Object> get props => [message];
}

class FetchFarmerProductsSuccess extends FarmerState {
  final List<FarmerProductModel> farmerNotificationModel;

  FetchFarmerProductsSuccess({this.farmerNotificationModel});

  @override
  List<Object> get props => [farmerNotificationModel];
}

class FarmerFailureState extends FarmerState {
  final String error;

  const FarmerFailureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

/*class GetPickUpAddress extends FarmerState {
  final String message;

  GetPickUpAddress({this.message});

  @override
  List<Object> get props => [message];
}*/
