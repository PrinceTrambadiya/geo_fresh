part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardInProgressState extends DashboardState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchStatusSuccess extends DashboardState {
  final bool status;
  final UserModel userModel;

  FetchStatusSuccess({this.status, this.userModel});

  @override
  List<Object> get props => [status, userModel];
}

// class FetchFarmerDataSuccess extends DashboardState {
//   final FarmerModel userModel;
//
//   const FetchFarmerDataSuccess({@required this.userModel});
//
//   @override
//   List<Object> get props => [userModel];
//
//   @override
//   String toString() => 'BusinessMan { error: $farmerModel }';
// }
//
// class FetchBusinessManDataSuccess extends DashboardState {
//   final BusinessmanModel businessManModel;
//
//   const FetchBusinessManDataSuccess({@required this.businessManModel});
//
//   @override
//   List<Object> get props => [businessManModel];
//
//   @override
//   String toString() => 'BusinessMan { error: $businessManModel }';
// }

class DashboardFailureState extends DashboardState {
  final String error;

  const DashboardFailureState({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'DashboardFailureState { error: $error }';
}
