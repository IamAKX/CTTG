part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class RequestLoginEvent extends LoginEvent {
  final LoginModel model;

  RequestLoginEvent(this.model) : super([model]);

  @override
  List<Object> get props => [model];
}
