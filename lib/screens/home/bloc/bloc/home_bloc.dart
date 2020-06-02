import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cttgfahrer/model/generic_response_model.dart';
import 'package:cttgfahrer/model/report_model.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is UpdateTimesheetEvent) {
      yield* _mapRequestLoginEvent(event.model);
    } else {
      yield HomeInitial();
    }
  }

  Stream<HomeState> _mapRequestLoginEvent(ReportModel model) async* {
    yield HomeProcessing();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    print(model.toString());
    if (preferences.getString('lastUpdated') == null ||
        preferences.getString('lastUpdated') !=
            "${now.day}${now.month}${now.year}") {
      var ref = Firestore.instance.collection('users').document(model.user.id);

      ref.get().then((doc) {
        var data = doc.data;
        print(data);
        data['scanner'] = model.scanner;
        data['kfz'] = model.car;
        data['tour'] = model.tour;
        data['breakTime'] = data['breakTime'] + model.breakHour;
        data['totalTime'] = data['totalTime'] + model.totalHour;
        data['workingTime'] = data['workingTime'] + model.workingHour;
        data['distance'] = data['distance'] + model.totalKM;

        ref.updateData(data);
        print('updated user');
      }).catchError((onError) {
        print('Failed to update user' + onError.toString());
      });
    } else {
      print('Already updated user');
    }

    String docId = model.user.email +
        "${model.currentDate.day}${model.currentDate.month}${model.currentDate.year}";

    var ref = Firestore.instance.collection('records').document(docId);
    var record = {
      "id": docId,
      "car": model.car,
      "tour": model.tour,
      "scanner": model.scanner,
      "startKM": model.startKM,
      "endKM": model.endKM,
      "totalKM": model.totalKM,
      "welle": model.welle,
      "tripStartTime": model.startTime,
      "tripEndTime": model.endTime,
      "totalWorkingTime": model.totalHour,
      "breakTime": model.breakHour,
      "effectiveTime": model.workingHour,
      "currentDate": model.currentDate,
      "userID": model.user.id,
      "userName": model.user.name,
      "userEmail": model.user.email
    };
    bool error = false;
    ref.setData(record).then((doc) {
      print('Updated record successful!');
    }).catchError((onError) {
      error = true;
      print('Update record failed!');
    });
    if (error)
      yield HomeFailed(
        GenericResponseModel(
            responseCode: 410, responseMessage: 'Failed to update'),
      );
    else {
      preferences.setString('car', model.car);
      preferences.setString('tour', model.tour);
      preferences.setString('scanner', model.scanner);
      preferences.setString('welle', model.welle);
      preferences.setString('endKM', model.endKM.toString());
      preferences.setString('lastUpdated',
          '${model.currentDate.day}${model.currentDate.month}${model.currentDate.year}');
      if (model.totalHour > 510) {
        var email = await Dio().post(
            "https://us-central1-cttgfahrer.cloudfunctions.net/userFunction/v1/user/email",
            data: {
              "subject": "Working time exceed",
              "msg": getEmailBody(model)
            });
        print('email : $email');
      } else {
        print('Skipping email');
      }

      yield HomeSuccess(
        GenericResponseModel(
            responseCode: 200, responseMessage: 'Updated successfully'),
      );
    }
  }

  getEmailBody(ReportModel model) {
    DateTime now = DateTime.now();
    return '''${model.user.name} has worked more that 8.5 hours today! Below is the retail report.<br/>
    <br/>
    ================================================================<br/>
    Date : ${now.day}/${now.month}/${now.year}<br/>
    Name : ${model.user.name}<br/>
    Email : ${model.user.email}<br/>
    KFZ : ${model.car}<br/>
    Tour : ${model.tour}<br/>
    Welle : ${model.welle}<br/>
    Scanner : ${model.scanner}<br/>
    Start time : ${model.startTime}<br/>
    End time : ${model.endTime}<br/>
    Total time : ${durationToString(model.totalHour)}<br/>
    Effective time : ${durationToString(model.workingHour)}<br/>
    Break time : ${durationToString(model.breakHour)}<br/>
    Start KM : ${model.startKM} KM<br/>
    End KM : ${model.endKM} KM<br/>
    ================================================================<br/>''';
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }
}
