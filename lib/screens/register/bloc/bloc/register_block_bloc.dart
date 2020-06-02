import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cttgfahrer/model/generic_response_model.dart';
import 'package:cttgfahrer/model/register_model.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_block_event.dart';
part 'register_block_state.dart';

class RegisterBlockBloc extends Bloc<RegisterBlockEvent, RegisterBlockState> {
  @override
  RegisterBlockState get initialState => RegisterBlockInitial();

  @override
  Stream<RegisterBlockState> mapEventToState(
    RegisterBlockEvent event,
  ) async* {
    if (event is RequestRegisterEvent) {
      yield* _mapRequestRegisterEvent(event.model);
    } else {
      yield RegisterBlockInitial();
    }
  }

  Stream<RegisterBlockState> _mapRequestRegisterEvent(
      RegisterModel model) async* {
    yield RegisterBlockProcessing();

    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: model.email)
        .getDocuments();
    if (querySnapshot.documents.length > 0) {
      yield RegisterBlockError(
        GenericResponseModel(
            responseCode: 400,
            responseMessage: 'This email is already registered'),
      );
      return;
    }

    var ref = Firestore.instance.collection('users').document();
    var user = {
      "id": ref.documentID,
      "name": model.name,
      "email": model.email,
      "password": model.password,
      "status": 0,
      "kfz": "-",
      "tour": "-",
      "scanner": "-",
      "workingTime": 0,
      "breakTime": 0,
      "totalTime": 0,
      "distance": 0,
    };

    bool error = false;
    ref.setData(user).then((doc) {
      print('Registration successful!');
    }).catchError((onError) {
      error = true;
      print('Registration failed!');
    });
    if (error)
      yield RegisterBlockError(
        GenericResponseModel(
            responseCode: 410, responseMessage: 'Failed to register'),
      );
    else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', user['email']);
      preferences.setString('name', user['name']);
      preferences.setString('id', user['id']);
      preferences.setBool('loggedIn', true);
      yield RegisterBlockSuccess(
        GenericResponseModel(
            responseCode: 200, responseMessage: 'Successfully registered'),
      );
    }
  }
}
