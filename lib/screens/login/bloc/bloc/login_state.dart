part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginProcessing extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  GenericResponseModel response;
  LoginSuccess(
    this.response,
  ) : super();

  @override
  List<Object> get props => [response];

  GenericResponseModel get getResponse => response;
}

class LoginFail extends LoginState {
  GenericResponseModel response;
  LoginFail(
    this.response,
  ) : super();

  @override
  List<Object> get props => [response];

  GenericResponseModel get getResponse => response;
}
