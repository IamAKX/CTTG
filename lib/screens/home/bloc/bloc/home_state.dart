part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeProcessing extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  GenericResponseModel response;
  HomeSuccess(
    this.response,
  ) : super();

  @override
  List<Object> get props => [response];

  GenericResponseModel get getResponse => response;
}

class HomeFailed extends HomeState {
  GenericResponseModel response;
  HomeFailed(
    this.response,
  ) : super();

  @override
  List<Object> get props => [response];

  GenericResponseModel get getResponse => response;
}
