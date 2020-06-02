part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super();
}

class UpdateTimesheetEvent extends HomeEvent {
  final ReportModel model;

  UpdateTimesheetEvent(this.model) : super([model]);

  @override
  List<Object> get props => [model];
}
