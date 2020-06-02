import 'dart:convert';

import 'package:cttgfahrer/model/user_model.dart';

class ReportModel {
  String car;
  String tour;
  String scanner;
  double startKM;
  double endKM;
  double totalKM;
  String welle;
  DateTime startTime;
  DateTime endTime;
  int totalHour;
  int breakHour;
  int workingHour;
  DateTime currentDate;
  UserModel user;
  ReportModel({
    this.car,
    this.tour,
    this.scanner,
    this.startKM,
    this.endKM,
    this.totalKM,
    this.welle,
    this.startTime,
    this.endTime,
    this.totalHour,
    this.breakHour,
    this.workingHour,
    this.currentDate,
    this.user,
  });

  ReportModel copyWith({
    String car,
    String tour,
    String scanner,
    double startKM,
    double endKM,
    double totalKM,
    String welle,
    DateTime startTime,
    DateTime endTime,
    int totalHour,
    int breakHour,
    int workingHour,
    DateTime currentDate,
    UserModel user,
  }) {
    return ReportModel(
      car: car ?? this.car,
      tour: tour ?? this.tour,
      scanner: scanner ?? this.scanner,
      startKM: startKM ?? this.startKM,
      endKM: endKM ?? this.endKM,
      totalKM: totalKM ?? this.totalKM,
      welle: welle ?? this.welle,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      totalHour: totalHour ?? this.totalHour,
      breakHour: breakHour ?? this.breakHour,
      workingHour: workingHour ?? this.workingHour,
      currentDate: currentDate ?? this.currentDate,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'car': car,
      'tour': tour,
      'scanner': scanner,
      'startKM': startKM,
      'endKM': endKM,
      'totalKM': totalKM,
      'welle': welle,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'totalHour': totalHour,
      'breakHour': breakHour,
      'workingHour': workingHour,
      'currentDate': currentDate?.millisecondsSinceEpoch,
      'user': user?.toMap(),
    };
  }

  static ReportModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReportModel(
      car: map['car'],
      tour: map['tour'],
      scanner: map['scanner'],
      startKM: map['startKM'],
      endKM: map['endKM'],
      totalKM: map['totalKM'],
      welle: map['welle'],
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
      totalHour: map['totalHour'],
      breakHour: map['breakHour'],
      workingHour: map['workingHour'],
      currentDate: DateTime.fromMillisecondsSinceEpoch(map['currentDate']),
      user: UserModel.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  static ReportModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReportModel(car: $car, tour: $tour, scanner: $scanner, startKM: $startKM, endKM: $endKM, totalKM: $totalKM, welle: $welle, startTime: $startTime, endTime: $endTime, totalHour: $totalHour, breakHour: $breakHour, workingHour: $workingHour, currentDate: $currentDate, user: $user)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReportModel &&
        o.car == car &&
        o.tour == tour &&
        o.scanner == scanner &&
        o.startKM == startKM &&
        o.endKM == endKM &&
        o.totalKM == totalKM &&
        o.welle == welle &&
        o.startTime == startTime &&
        o.endTime == endTime &&
        o.totalHour == totalHour &&
        o.breakHour == breakHour &&
        o.workingHour == workingHour &&
        o.currentDate == currentDate &&
        o.user == user;
  }

  @override
  int get hashCode {
    return car.hashCode ^
        tour.hashCode ^
        scanner.hashCode ^
        startKM.hashCode ^
        endKM.hashCode ^
        totalKM.hashCode ^
        welle.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        totalHour.hashCode ^
        breakHour.hashCode ^
        workingHour.hashCode ^
        currentDate.hashCode ^
        user.hashCode;
  }
}
