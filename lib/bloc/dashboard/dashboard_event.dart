part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class CheckStatusOfUser extends DashboardEvent {
  const CheckStatusOfUser();

  @override
  List<Object> get props => [];
}

// class FetchFarmerData extends DashboardEvent {
//   const FetchFarmerData();
//
//   @override
//   List<Object> get props => [];
// }
//
// class FetchBusinessManData extends DashboardEvent {
//   const FetchBusinessManData();
//
//   @override
//   List<Object> get props => [];
// }
