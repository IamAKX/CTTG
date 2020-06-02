import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cttgfahrer/model/generic_response_model.dart';
import 'package:cttgfahrer/model/login_model.dart';
import 'package:cttgfahrer/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is RequestLoginEvent) {
      yield* _mapRequestLoginEvent(event.model);
    } else {
      yield LoginInitial();
    }
  }

  Stream<LoginState> _mapRequestLoginEvent(LoginModel model) async* {
    yield LoginProcessing();

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: model.email)
        .getDocuments();
    if (querySnapshot.documents.length == 0) {
      yield LoginFail(
        GenericResponseModel(
            responseCode: 400, responseMessage: 'This email is not registered'),
      );
      return;
    } else {
      GenericResponseModel responseModel;
      UserModel user = UserModel();
      querySnapshot.documents.forEach((doc) => {
            user = UserModel(
                email: doc['email'],
                name: doc['name'],
                id: doc['id'],
                password: doc['password'],
                status: doc['status'])
          });

      if (user.email == model.email && user.password == model.password) {
        if (user.status == 1) {
          responseModel = GenericResponseModel(
              responseCode: 200, responseMessage: 'Login sucessfull');
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('email', user.email);
          preferences.setString('name', user.name);
          preferences.setString('id', user.id);
          preferences.setBool('loggedIn', true);

          yield LoginSuccess(responseModel);
        } else {
          responseModel = GenericResponseModel(
              responseCode: 402,
              responseMessage: 'Your profile is not activiated yet');
          yield LoginFail(responseModel);
        }
      } else {
        responseModel = GenericResponseModel(
            responseCode: 401, responseMessage: 'Incorrect password');
        yield LoginFail(responseModel);
      }
    }
  }
}
