part of 'register_block_bloc.dart';

abstract class RegisterBlockEvent extends Equatable {
  RegisterBlockEvent([List props = const []]) : super();
}

class RequestRegisterEvent extends RegisterBlockEvent {
  final RegisterModel model;

  RequestRegisterEvent(this.model) : super([model]);

  @override
  List<Object> get props => [model];
}
