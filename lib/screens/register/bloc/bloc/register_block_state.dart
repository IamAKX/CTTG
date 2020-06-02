part of 'register_block_bloc.dart';

abstract class RegisterBlockState extends Equatable {
  RegisterBlockState([List props = const []]) : super();
}

class RegisterBlockInitial extends RegisterBlockState {
  @override
  List<Object> get props => [];
}

class RegisterBlockProcessing extends RegisterBlockState {
  @override
  List<Object> get props => [];
}

class RegisterBlockSuccess extends RegisterBlockState {
  GenericResponseModel response;
  RegisterBlockSuccess(
    this.response,
  ) : super();

  @override
  List<Object> get props => [response];

  GenericResponseModel get getResponse => response;
}

class RegisterBlockError extends RegisterBlockState {
  GenericResponseModel response;
  RegisterBlockError(
    this.response,
  ) : super();

  @override
  List<Object> get props => [response];

  GenericResponseModel get getResponse => response;
}
