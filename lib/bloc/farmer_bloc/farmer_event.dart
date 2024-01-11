part of 'farmer_bloc.dart';

abstract class FarmerEvent extends Equatable {
  const FarmerEvent();
}

class FarmerInitialEvent extends FarmerEvent {
  const FarmerInitialEvent();

  @override
  List<Object> get props => [];
}

class FetchPinCodeData extends FarmerEvent {
  final String pinCode;

  const FetchPinCodeData({this.pinCode});

  @override
  List<Object> get props => [pinCode];
}

class AddRegistrationOfFarmer extends FarmerEvent {
  final UserModel userModel;

  const AddRegistrationOfFarmer({this.userModel});

  @override
  List<Object> get props => [userModel];
}

class AddProductOfFarmer extends FarmerEvent {
  final ProductModel productModel;

  const AddProductOfFarmer({this.productModel, ProductModel});

  @override
  List<Object> get props => [productModel];
}

class AddProductBidPrice extends FarmerEvent {
  final ProductModel userModel;

  const AddProductBidPrice({this.userModel});

  @override
  List<Object> get props => [userModel];
}

class FetchFarmerProducts extends FarmerEvent {
  const FetchFarmerProducts();

  @override
  List<Object> get props => [];
}

class AddEditPickUpAddress extends FarmerEvent {
  const AddEditPickUpAddress();

  @override
  List<Object> get props => [];
}
